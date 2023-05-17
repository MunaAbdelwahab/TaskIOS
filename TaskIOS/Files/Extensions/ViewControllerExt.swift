//
//  ViewControllerExt.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import UIKit

enum AlertStyle {
    case reguler, withScope, withButton
}

extension UIViewController {
    
    func showAlert(with Style: AlertStyle, msg: String,  compilition: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            
            switch Style {
            case .reguler, .withScope:
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
                    alert.dismiss(animated: true){
                        compilition?()
                    }
                }
                break
                
            case .withButton:
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                break
    
            }
            
            self.present(alert, animated: true)
        }
    }
}
