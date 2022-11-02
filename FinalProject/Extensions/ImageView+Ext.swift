//
//  Dowload+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 02/11/2022.
//

import Foundation
import UIKit

extension UIImageView {

    func downloadImage(from url: String) {
        guard let url = URL(string: url) else {
            self.image = nil
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.image = image
                    }
                } else {
                    self.image = nil
                }
            }
        }
        task.resume()
    }
}
