//
//  NumberFormatterHelperTests.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 14/11/24.
//

import XCTest
@testable import Top10_Movies

class NumberFormatterHelperTests: XCTestCase {

    func testFormatToOneDecimalPlaces_withPositiveNumber() {
        let number = 12.345
        let formattedNumber = NumberFormatterHelper.formatToOneDecimalPlaces(number)
        
        XCTAssertEqual(formattedNumber, "12.3")
    }

    func testFormatToOneDecimalPlaces_withNegativeNumber() {
        let number = -12.345
        let formattedNumber = NumberFormatterHelper.formatToOneDecimalPlaces(number)
        
        XCTAssertEqual(formattedNumber, "-12.3")
    }

    func testFormatToOneDecimalPlaces_withZero() {
        let number = 0.0
        let formattedNumber = NumberFormatterHelper.formatToOneDecimalPlaces(number)
        
        XCTAssertEqual(formattedNumber, "0.0")
    }

    func testFormatToOneDecimalPlaces_withRounding() {
        let number = 2.75
        let formattedNumber = NumberFormatterHelper.formatToOneDecimalPlaces(number)
        
        XCTAssertEqual(formattedNumber, "2.8")
    }
}
