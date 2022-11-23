//
//  String+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 22/11/2022.
//

import Foundation

extension String {
    var isNumeric: Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
}
