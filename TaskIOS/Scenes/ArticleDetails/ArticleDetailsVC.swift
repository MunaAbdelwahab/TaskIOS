//
//  ArticleDetailsVC.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 18/05/2023.
//

import UIKit
import Cosmos

class ArticleDetailsVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var rateNum: UITextField!
    @IBOutlet weak var rate: CosmosView!
    
    var articleUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if articleUrl.isEmpty {
            showAlert(with: .reguler, msg: "No connection.")
        } else {
            if let url = URL (string: articleUrl) {
                let requestObj = URLRequest(url: url)
                webView.loadRequest(requestObj)
            }
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        if rateNum.text == "1" || rateNum.text == "2" || rateNum.text == "3" || rateNum.text == "4" || rateNum.text == "5" {
            let rateT = rateNum.text
            rate.rating = Double(rateT ?? "")!
            showAlert(with: .reguler, msg: "You have successfully rated the article.")
        } else {
            rate.rating = 0
            showAlert(with: .reguler, msg: "Rate out of range.")
        }
    }
}
