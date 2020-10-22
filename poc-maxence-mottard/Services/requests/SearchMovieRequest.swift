//
//  SearchMovieRequest.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 21/10/2020.
//

import Foundation
import RxSwift

class SearchMovieRequest: ApiRequest {
    typealias ResultType = MoviesRequest
    var jsonDecoder: JSONDecoder!
    var localeFormatter: LocaleFormatter!

    func fetch(_ query: String) -> Observable<MoviesRequest> {
        let language = localeFormatter.getTMDBLanguageCode()

        let urlComponents = URLComponents(
            host: Constant.TMDBBaseUrl.rawValue,
            path: "/3/search/movie",
            queryItems: [
                URLQueryItem(name: "language", value: language.rawValue),
                URLQueryItem(name: "api_key", value: Constant.TMDBApiKey.rawValue),
                URLQueryItem(name: "query", value: query)
            ]
        )

        guard let url = urlComponents.url else {
            return Observable.empty()
        }

        return request(url.absoluteString)
    }

}
