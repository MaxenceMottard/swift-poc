//
//  DetailModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation

struct DetailModel {
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    
    static func from(_ movie: Movie) -> DetailModel {
        return DetailModel(title: movie.title, overview: movie.overview, releaseDate: movie.releaseDate, posterPath: movie.posterPath, backdropPath: movie.backdropPath)
    }
}
