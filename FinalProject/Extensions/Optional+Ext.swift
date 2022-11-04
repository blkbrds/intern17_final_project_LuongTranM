//
//  Optional+Ext.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

extension Optional where Wrapped == String {
    var content: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case .none:
            return ""
        }
    }
}

extension Optional where Wrapped == Int {
  func unwrap(or wrapped: Wrapped) -> Wrapped {
    guard let number = self else { return wrapped }
    return number
  }
}
