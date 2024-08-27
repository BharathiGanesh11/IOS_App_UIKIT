//
//  String+Ext.swift
//  GitHub Followers
//
//  Created by Kumar on 27/08/24.
//

import Foundation

extension String
{
    func convertToDate() -> Date?
    {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = .current
        return df.date(from: self)
    }
    
    func convertToGFDateFormat() -> String
    {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertDateToMonthAndYearFormat()
    }
}
