//
//  DateFormatterHelper.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 13/11/24.
//

import Foundation

class DateFormatterHelper {
    
    static func getYear(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let year = Calendar.current.component(.year, from: date)
            return String(year)
        } else {
            return ""
        }
    }
    
    static func convertDateString(inputDate: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"        
        guard let date = inputDateFormatter.date(from: inputDate) else {
            return "nil"
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMMM dd, yyyy"  // Output format: "November 22, 2024"

        return outputDateFormatter.string(from: date)
    }
}
