//
//  TimeFormatterHelperTests.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 17/11/24.
//

import XCTest
@testable import Top10_Movies

class TimeFormatterHelperTests: XCTestCase {

    func testConvertMinutesToHourFormat_withMinutesLessThan60_returnsMinutes() {
        // Test for minutes less than 60
        let result = TimeFormatterHelper.convertMinutesToHourFormat(minutes: 45)
        XCTAssertEqual(result, "45m")
    }
    
    func testConvertMinutesToHourFormat_withExactHour_returnsHoursOnly() {
        // Test for 60 minutes
        let result = TimeFormatterHelper.convertMinutesToHourFormat(minutes: 60)
        XCTAssertEqual(result, "1h")
    }
    
    func testConvertMinutesToHourFormat_withMoreThanOneHour_returnsHoursAndMinutes() {
        // Test for more than 1 hour
        let result = TimeFormatterHelper.convertMinutesToHourFormat(minutes: 90)
        XCTAssertEqual(result, "1h 30m")
    }
    
    func testConvertMinutesToHourFormat_withMultipleHours_returnsHoursOnly() {
        // Test for more than 2 hours
        let result = TimeFormatterHelper.convertMinutesToHourFormat(minutes: 120)
        XCTAssertEqual(result, "2h")
    }
}
