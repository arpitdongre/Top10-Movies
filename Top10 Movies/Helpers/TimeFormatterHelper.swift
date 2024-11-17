//
//  TimeFormatterHelper.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 17/11/24.
//

import Foundation

class TimeFormatterHelper {
  
    static func convertMinutesToHourFormat(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        if hours > 0 {
            if remainingMinutes > 0 {
                return "\(hours)h \(remainingMinutes)m"
            } else {
                return "\(hours)h"
            }
        } else {
            return "\(remainingMinutes)m"
        }
    }
}
