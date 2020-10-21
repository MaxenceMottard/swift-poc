//
//  tmdbApiTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 20/10/2020.
//

import XCTest
import Alamofire
@testable import poc_maxence_mottard

class TmdbApiTests: XCTestCase {

    func testGetENMovies() {
        let language = LocaleFormatter.TMDBLanguage.en
        AF.request("\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)").response { response in
            XCTAssertEqual(response.response?.statusCode, 200)
        }
    }

    func testGetFRMovies() {
        let language = LocaleFormatter.TMDBLanguage.fr
        AF.request("\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)").response { response in
            XCTAssertEqual(response.response?.statusCode, 200)
        }
    }

    func testMovieDBImageUrlGeneration() {
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
