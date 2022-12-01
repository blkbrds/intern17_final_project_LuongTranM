//
//  Date+Ext.swift
//  FinalProject
//
//  Created by luong.tran on 29/11/2022.
//

import Foundation

extension Date {
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        olDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM, yyyy"
        return convertDateFormatter.string(from: oldDate ?? Date())
    }
}
