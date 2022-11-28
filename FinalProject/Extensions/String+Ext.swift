//
//  String+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 22/11/2022.
//

import Foundation
import UIKit

extension String {
    var isNumeric: Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }

    func checkTypeRegex(typeRegex: RegexType) -> Bool {
        let regex = typeRegex.rawValue
        let regexCase = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexCase.evaluate(with: self)
    }
}
