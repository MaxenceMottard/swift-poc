//
//  tmdbApiTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 20/10/2020.
//

import XCTest
import Alamofire
@testable import poc_maxence_mottard

class tmdbApiTests: XCTestCase {
    
    func testGetENMovies() {
        let language = LocaleService.TMDBLanguage.en
        AF.request("\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)").response { response in
            XCTAssertEqual(response.response?.statusCode, 200)
        }
    }
    
    func testGetFRMovies() {
        let language = LocaleService.TMDBLanguage.fr
        AF.request("\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)").response { response in
            XCTAssertEqual(response.response?.statusCode, 200)
        }
    }
    
}
