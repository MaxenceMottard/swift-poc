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
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }

    func getImageUrl(size: TmdbImageSize.Poster) -> URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "\(Constant.TMDBImageBaseUrl.rawValue)\(size)\(path)")
    }

    func getImageUrl(size: TmdbImageSize.Backdrop) -> URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "\(Constant.TMDBImageBaseUrl.rawValue)\(size)\(path)")
    }
}
