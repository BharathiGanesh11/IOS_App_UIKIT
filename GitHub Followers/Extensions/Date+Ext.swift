//
//  Date+Ext.swift
//  GitHub Followers
//
//  Created by Kumar on 27/08/24.
//

import Foundation

extension Date
{
    func convertDateToMonthAndYearFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM yyyy"
        return df.string(from: self)
    }
}
