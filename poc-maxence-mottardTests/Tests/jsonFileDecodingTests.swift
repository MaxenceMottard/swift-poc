//
//  jsonFileDecodingTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 20/10/2020.
//

import XCTest
@testable import poc_maxence_mottard

class jsonFileDecodingTests: XCTestCase {
    
    func testMovieProperties() {
        let di = getDependencyProvider()
        let movieDBApi = di.resolve(MovieDBApi.self)!
        let movies = movieDBApi.getMockingMovies()
        
        XCTAssertEqual(movies.count, 2)
        XCTAssertEqual(movies[0].title, "Joker")
        XCTAssertEqual(movies[1].title, "Interstellar")
        XCTAssertNotNil(movies[0].overview)
    }
    
}
