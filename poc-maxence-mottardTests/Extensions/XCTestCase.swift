//
//  XCTestCase.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 19/10/2020.
//

import XCTest
import Fakery
@testable import poc_maxence_mottard

extension XCTestCase {
    func getFaker() -> Faker {
        return Faker(locale: LocaleFormatter.SupportedLanguage.en.rawValue)
    }

    func getDependencyProvider() -> DependencyProvider {
        return DependencyProvider()
    }
}
