//
//  URLComponents.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 22/10/2020.
//

import Foundation

extension URLComponents {
    init(scheme: String = "https", host: String, path: String, queryItems: [URLQueryItem] = []) {
        self.init()
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}
