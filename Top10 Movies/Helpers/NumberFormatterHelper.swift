//
//  NumberFormatterHelper.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 13/11/24.
//

import Foundation

class NumberFormatterHelper {
    
    static func formatToOneDecimalPlaces(_ number: Double) -> String {
        return String(format: "%.1f", number)
    }
}
