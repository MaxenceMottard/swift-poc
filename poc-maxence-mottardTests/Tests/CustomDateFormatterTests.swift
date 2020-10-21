//
//  poc_maxence_mottardTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 29/09/2020.
//

import XCTest
import Fakery
@testable import poc_maxence_mottard

class CustomDateFormatterTests: XCTestCase {
    func testDateConvertion() throws {
        let di = getDependencyProvider()
        let dateFormatter = di.resolve(CustomDateFormatter.self)!

        let stringDate = "2201-01-27"
        XCTAssertEqual(dateFormatter.convertToReadableDate(stringDate), "27 janvier 2201")
    }
}
