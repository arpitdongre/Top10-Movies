//
//  DateFormatterHelperTests.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 14/11/24.
//

import XCTest
@testable import Top10_Movies

class DateFormatterHelperTests: XCTestCase {

    func testGetYear_withValidDate() {
        let validDateString = "2024-11-11"
        
        let result = DateFormatterHelper.getYear(dateString: validDateString)
        
        XCTAssertEqual(result, "2024")
    }
    
    func testGetYear_withEmptyString() {
        let emptyDateString = ""
        let result = DateFormatterHelper.getYear(dateString: emptyDateString)
        
        XCTAssertEqual(result, "")
    }

    func testGetYear_withIncorrectDate() {
        let incorrectDateString = "2024-13-01"
        let result = DateFormatterHelper.getYear(dateString: incorrectDateString)
        
        XCTAssertEqual(result, "")
    }

    func testGetYear_withLeapYearDate() {
        let leapYearDateString = "2024-02-29"
        let result = DateFormatterHelper.getYear(dateString: leapYearDateString)
        
        XCTAssertEqual(result, "2024")
    }
    
    func testConvertDateString_withValidDate_returnsFormattedDate() {
        let result = DateFormatterHelper.convertDateString(inputDate: "2024-11-17")
        XCTAssertEqual(result, "November 17, 2024")
    }
    
    func testConvertDateString_withInvalidDate_returnsNil() {
        let result = DateFormatterHelper.convertDateString(inputDate: "2024-13-40")
        XCTAssertEqual(result, "nil")
    }

    func testConvertDateString_withEmptyString_returnsNil() {
        let result = DateFormatterHelper.convertDateString(inputDate: "")
        XCTAssertEqual(result, "nil")
    }
}
