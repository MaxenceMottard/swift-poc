//
//  DetailModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation
import UIKit

struct DetailModel {
    let title: String
    let overview: String
    let releaseDate: String
    let posterUrl: URL?
    let posterOriginalUrl: URL?
    let backdropPadUrl: URL?
    let backdropPhoneUrl: URL?

    static func from(_ movie: Movie) -> DetailModel {
        return DetailModel(
            title: movie.title,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            posterUrl: movie.getImageUrl(size: .w185),
            posterOriginalUrl: movie.getImageUrl(size: TmdbImageSize.Poster.original),
            backdropPadUrl: movie.getImageUrl(size: TmdbImageSize.Backdrop.w1280),
            backdropPhoneUrl: movie.getImageUrl(size: TmdbImageSize.Backdrop.w780))

    }
}
