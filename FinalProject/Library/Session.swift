//
//  Session.swift
//  FinalProject
//
//  Created by luong.tran on 07/11/2022.
//

import Foundation

class Session {

    static let shared: Session = {
        let shared: Session = Session()
        return shared
    }()

    var token: String {
        get {
            return ud.string(forKey: KeysUserDefault.Keys.token.rawValue).content
        }
        set {
            return ud.set(newValue, forKey: KeysUserDefault.Keys.token.rawValue)
        }
    }
}

struct KeysUserDefault {
    enum Keys: String, CaseIterable {
        case token = "token"
    }
}
