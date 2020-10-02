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
    let posterPath: String
    
    static func from(_ movie: Movie) -> ListCellModel {
        return ListCellModel(title: movie.title, overview: movie.overview, posterPath: movie.posterPath)
    }
}
