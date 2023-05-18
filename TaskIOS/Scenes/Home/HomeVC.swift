//
//  ViewController.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Network
import SafariServices

class HomeVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var articlesTV: UITableView!
    @IBOutlet weak var articlesTVHeight: NSLayoutConstraint!
    
    //MARK:- Variables
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    var noConnection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        
        if Connectivity.isConnectedToInternet {
             print("Connected")
            noConnection = false
            bindArticlesDataToArticlesCV()
         } else {
             print("No Internet")
             noConnection = true
             bindArticlesCacheDataToArticlesCV()
        }
        
        registerCells()
        subscribeToAlert()
        viewModel.getArticles()
        subscribeToArticlesSelection()
    }
    
    private func registerCells(){
        articlesTV.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    }
    
    private func bindArticlesDataToArticlesCV() {
        viewModel.homeCategoriesObserver.bind(to: articlesTV.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self )) {[weak self] (row, article, cell) in
            guard let self = self else {return}
            cell.setData(image: article.urlToImage ?? "" , name: article.title, desc: article.description ?? "")
            cell.layoutIfNeeded()
            self.articlesTV.layoutIfNeeded()
            self.articlesTVHeight.constant = self.articlesTV.contentSize.height
        }.disposed(by: disposeBag)
    }
    
    private func bindArticlesCacheDataToArticlesCV() {
        viewModel.homeCategoriesCacheObserver.bind(to: articlesTV.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self )) {[weak self] (row, article, cell) in
            guard let self = self else {return}
            cell.name.text = article.title
            cell.desc.text = article.desc
            
            let formattedString = article.urlToImage?.replacingOccurrences(of: " ", with: "%20")
            cell.imageArticle.sd_setImage(with: URL(string: formattedString ?? "")) {[weak self] img, _, _, _ in
                guard let self = self else {return}
                if let _ = img{
                } else {
                    cell.imageArticle.image = UIImage(named: "")
                }
            }
            cell.layoutIfNeeded()
            self.articlesTV.layoutIfNeeded()
            self.articlesTVHeight.constant = self.articlesTV.contentSize.height
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToArticlesSelection() {
        if !noConnection {
            Observable.zip(articlesTV.rx.itemSelected, articlesTV.rx.modelSelected(ArticlesData.self)).bind { [weak self] (indexPath, article) in
                guard let self = self else {return}
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsVC") as! ArticleDetailsVC
                VC.articleUrl = article.url
                self.navigationController?.pushViewController(VC, animated: true)
            }.disposed(by: disposeBag)
        } else {
            Observable.zip(articlesTV.rx.itemSelected, articlesTV.rx.modelSelected(Articles.self)).bind { [weak self] (indexPath, article) in
                guard let self = self else {return}
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsVC") as! ArticleDetailsVC
                VC.articleUrl = article.url ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }.disposed(by: disposeBag)
        }
    }
    
    private func subscribeToAlert() {
        viewModel.alertBehavior.subscribe({ [weak self] (alert) in
            guard let self = self else {return}
            if alert.element ?? "" != "" {
                self.showAlert(with: .reguler, msg: alert.element!)
            }
        }).disposed(by: disposeBag)
    }
}
