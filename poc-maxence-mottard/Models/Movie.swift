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
    let poster_path: String
    let backdrop_path: String
    let release_date: String
}
