//
//  LanguageFormatterHelper.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 18/11/24.
//

import Foundation
import XCTest
@testable import Top10_Movies

class LanguageFormatterHelperTests: XCTestCase {
    
    func testGetLanguageNameForValidShortForm() {
        LanguageFormatterHelper.locale = Locale(identifier: "en_US")
        
        let englishName = LanguageFormatterHelper.getLanguageName(for: "en")
        XCTAssertEqual(englishName, "English")
        
        let spanishName = LanguageFormatterHelper.getLanguageName(for: "es")
        XCTAssertEqual(spanishName, "Spanish")
    }
    
    func testGetLanguageNameForUnknownShortForm() {
        LanguageFormatterHelper.locale = Locale(identifier: "en_US")
        
        let unknownName = LanguageFormatterHelper.getLanguageName(for: "zz")
        XCTAssertEqual(unknownName, "Unknown language")
    }
    
    func testGetLanguageNameForEmptyShortForm() {
        LanguageFormatterHelper.locale = Locale(identifier: "en_US")
        
        let emptyShortFormName = LanguageFormatterHelper.getLanguageName(for: "")
        XCTAssertEqual(emptyShortFormName, "Unknown language")
    }
}
