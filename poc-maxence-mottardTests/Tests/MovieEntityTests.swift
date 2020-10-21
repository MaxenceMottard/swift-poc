//
//  jsonFileDecodingTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 20/10/2020.
//

import XCTest
import Foundation
@testable import poc_maxence_mottard

class MovieEntityTests: XCTestCase {
    
    func testMovieProperties() {
        let faker = getFaker()
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        var object = Dictionary<String, String>()
        
        object["title"] = faker.lorem.words()
        object["overview"] = faker.lorem.paragraphs()
        object["poster_path"] = faker.lorem.characters()
        object["backdrop_path"] = faker.lorem.characters()
        object["release_date"] = faker.business.creditCardNumber()
        
        do {
            let data = try encoder.encode(object)
            let movie = try decoder.decode(Movie.self, from: data)
            
            XCTAssertEqual(movie.title, object["title"])
            XCTAssertEqual(movie.overview, object["overview"])
            XCTAssertEqual(movie.posterPath, object["poster_path"])
            XCTAssertEqual(movie.backdropPath, object["backdrop_path"])
            XCTAssertEqual(movie.releaseDate, object["release_date"])
        } catch let error {
            XCTFail("ERROR: \(error.localizedDescription)")
        }
        
    }
    
}
