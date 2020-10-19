//
//  ListCellModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation

struct ListCellModel {
    let title: String
    let overview: String
    var posterUrl: URL?
    
    static func from(_ movie: Movie) -> ListCellModel {
        return ListCellModel(
            title: movie.title,
            overview: movie.overview,
            posterUrl: movie.getImageUrl(size: MovieDBApi.PosterSizes.w185))
    }
}
