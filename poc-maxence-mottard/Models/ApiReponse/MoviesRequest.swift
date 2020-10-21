//
//  MoviesRequest.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation

struct MoviesRequest: Decodable {
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
    let page: Int

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case page = "page"
    }
}
