//
//  detailViewModelTests.swift
//  poc-maxence-mottardTests
//
//  Created by Maxence on 19/10/2020.
//

import XCTest
@testable import poc_maxence_mottard

class detailViewModelTests: XCTestCase {
    
    func test1() {
        let faker = getFaker()
        let di = getDependencyProvider()
        
        let myMovie = Movie(
            title: faker.zelda.game(),
            overview: faker.lorem.paragraphs(amount: 4),
            posterPath: "/\(faker.lorem.characters(amount: 13)).png",
            backdropPath: "/\(faker.lorem.characters(amount: 13)).png",
            releaseDate: "2020-01-27")
        
        let detailModel = DetailModel.from(myMovie)
        let detailViewModel = di.container.resolve(DetailViewModel.self, argument: detailModel)!
        
        XCTAssertEqual(detailViewModel.model.title, myMovie.title)
        XCTAssertEqual(detailViewModel.model.overview, myMovie.overview)
        XCTAssertEqual(detailViewModel.model.posterUrl, myMovie.getImageUrl(size: MovieDBApi.PosterSizes.w185))
        XCTAssertEqual(detailViewModel.model.backdropPhoneUrl, myMovie.getImageUrl(size: MovieDBApi.BackdropSize.w780))
        XCTAssertEqual(detailViewModel.model.backdropPadUrl, myMovie.getImageUrl(size: MovieDBApi.BackdropSize.w1280))
        XCTAssertEqual(detailViewModel.model.releaseDate, myMovie.releaseDate)
    }
    
}
