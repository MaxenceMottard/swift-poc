//
//  TmdbImageSize.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 21/10/2020.
//

import Foundation

struct TmdbImageSize {
    enum Poster {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum Backdrop {
        case w300, w780, w1280, original
    }
}
