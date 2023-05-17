//
//  HomeViewModel.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: AlertViewModel {
    
    let homeService = HomeServices()
    let disposeBag = DisposeBag()
    
    var alertBehavior: BehaviorRelay = BehaviorRelay<String>(value: "")
    
    private var homeCategoriesSubject: PublishSubject = PublishSubject<[ArticlesData]>()
    var homeCategoriesObserver: Observable<[ArticlesData]>{
        return homeCategoriesSubject
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
                    self.homeCategoriesSubject.onNext(response.articles)
                }else{
                    self.alertSubject.onNext(response.status)
                }
            case .failure(let error):
                self.alertSubject.onNext(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
}
