//
//  UITextField+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 04/11/2022.
//

import Foundation
import UIKit

extension UITextField {

    func setupLeftSideImage(imageViewName: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: imageViewName)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageViewContainerView.addSubview(imageView)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .black
    }

    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
