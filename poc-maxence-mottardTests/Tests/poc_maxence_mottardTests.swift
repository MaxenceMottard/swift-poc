//
//  poc_maxence_mottardTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 29/09/2020.
//

import XCTest
import Fakery
@testable import poc_maxence_mottard

class poc_maxence_mottardTests: XCTestCase {    
    func testDateConvertion() throws {
        let di = getDependencyProvider()
        let dateService = di.resolve(DateService.self)!
        
        let stringDate = "2201-01-27"
        XCTAssertEqual(dateService.convertToReadableDate(stringDate), "27 janvier 2201")
    }
    
    func testMovieDBImageUrl() {
        let faker = getFaker()
        
        let myMovie = Movie(
            title: faker.zelda.game(),
            overview: faker.lorem.paragraphs(amount: 4),
            posterPath: "/\(faker.lorem.characters(amount: 13)).png",
            backdropPath: "/\(faker.lorem.characters(amount: 13)).png",
            releaseDate: "2020-01-27")
        
        XCTAssertEqual(
            myMovie.getImageUrl(size: MovieDBApi.PosterSizes.w92)?.absoluteString,
            "https://image.tmdb.org/t/p/\(MovieDBApi.PosterSizes.w92)\(myMovie.posterPath)"
        )
    }
}
