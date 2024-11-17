//
//  Untitled.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 18/11/24.
//

import Foundation

class LanguageFormatterHelper {
    
    static var locale: Locale = Locale(identifier: "en_US")
    
    static func getLanguageName(for shortForm: String) -> String {
        if let languageName = locale.localizedString(forLanguageCode: shortForm) {
            return languageName
        } else {
            return "Unknown language"
        }
    }
}
