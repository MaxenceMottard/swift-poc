//
//  MoviesRequest.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation

struct MoviesRequest: Decodable {
    let results: [Movie]
    let total_results: Int
    let total_pages: Int
    let page: Int
}
