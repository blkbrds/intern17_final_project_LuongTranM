//
//  UIViewController+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 07/11/2022.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func alert(msg: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default) { _ in
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
