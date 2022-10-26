//
//  Optional+Ext.swift
//  FinalProject
//
//  Created by Quoc Doan M. VN.Danang on 10/26/22.
//

import Foundation

extension Optional {
    var content: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case .none:
            return ""
        }
    }
}
