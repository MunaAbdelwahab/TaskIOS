//
//  HomeViewModel.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class HomeViewModel: AlertViewModel {
    
    let homeService = HomeServices()
    let disposeBag = DisposeBag()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var alertBehavior: BehaviorRelay = BehaviorRelay<String>(value: "")
    
    private var homeCategoriesSubject: PublishSubject = PublishSubject<[ArticlesData]>()
    var homeCategoriesObserver: Observable<[ArticlesData]>{
        return homeCategoriesSubject
    }
    
    private var homeCategoriesCacheSubject: PublishSubject = PublishSubject<[Articles]>()
    var homeCategoriesCacheObserver: Observable<[Articles]>{
        return homeCategoriesCacheSubject
    }
    
    private var alertSubject = PublishSubject<String>()
    var alertObservable: Observable<String>{
        return alertSubject
    }
    
    func getArticles() {
        homeService.getHomeData().subscribe(onNext: {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                if response.status == "ok" {
                    deleteAllData("Articles")
                    fetchData(articles: response.articles)
                    self.homeCategoriesSubject.onNext(response.articles)
                } else {
                    self.alertSubject.onNext(response.status)
                }
            case .failure(let error):
                fetchCacheData()
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchCacheData() {
        do {
            let articles = try context.fetch(Articles.fetchRequest())
            self.homeCategoriesCacheSubject.onNext(articles)
        } catch {
            
        }
    }
    
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(Articles.fetchRequest())
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func fetchData(articles: [ArticlesData]) {
        for article in articles {
            let articlesCache = Articles(context: self.context)
            articlesCache.publishedAt = article.publishedAt
            articlesCache.desc = article.description
            articlesCache.title = article.title
            articlesCache.urlToImage = article.urlToImage
            articlesCache.url = article.url
            do {
                try self.context.save()
            } catch {
                
            }
        }
        
    }
    
}
