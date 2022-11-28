//
//  Regex.swift
//  FinalProject
//
//  Created by luong.tran on 25/11/2022.
//

import Foundation

typealias RegexType = RegexValidate.TypeRegex

class RegexValidate {

    static let shared: RegexValidate = {
        let shared: RegexValidate = RegexValidate()
        return shared
    }()

    enum TypeRegex: String {
        case number = ".*[0-9]+.*"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[com]{3}"
    }
}
