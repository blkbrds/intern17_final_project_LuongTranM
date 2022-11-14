//
//  UIViewController+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 07/11/2022.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func alert(buttonTitle: String = "Cancel", title: String = "ERROR", msg: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(cancelButton)
        present(alert, animated: false)
    }

    func showHUD() {
        SVProgressHUD.show()
    }

    func dismissHUD() {
        SVProgressHUD.dismiss()
    }
}
