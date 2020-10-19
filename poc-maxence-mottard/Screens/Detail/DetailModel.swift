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
    let backdropUrl: URL?
    
    static func from(_ movie: Movie) -> DetailModel {
        return DetailModel(
            title: movie.title,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            posterUrl: movie.getImageUrl(size: .w185),
            backdropUrl: movie.getImageUrl(size: UIDevice.current.userInterfaceIdiom == .pad ? .w780 : .w1280))
    }
}
