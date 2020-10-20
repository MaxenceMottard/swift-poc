//
//  Movie.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
    
    func getImageUrl(size: PopularMovieRequest.PosterSizes) -> URL? {
        return URL(string: "\(Constant.TMDBImageBaseUrl.rawValue)\(size)\(posterPath)")
    }
    
    func getImageUrl(size: PopularMovieRequest.BackdropSize) -> URL? {
        return URL(string: "\(Constant.TMDBImageBaseUrl.rawValue)\(size)\(backdropPath)")
    }
}
