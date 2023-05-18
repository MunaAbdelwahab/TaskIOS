//
//  ArticleDetailsVC.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 18/05/2023.
//

import UIKit

class ArticleDetailsVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var rateNum: UITextField!
    
    var articleUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL (string: articleUrl) {
            let requestObj = URLRequest(url: url)
            webView.loadRequest(requestObj)
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        
    }
}
