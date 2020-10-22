//
//  MovieApi.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation
import Alamofire
import RxSwift

class PopularMovieRequest: ApiRequest {
    typealias ResultType = MoviesRequest
    var jsonDecoder: JSONDecoder!
    var localeFormatter: LocaleFormatter!

    func fetch() -> Observable<MoviesRequest> {
        let language = localeFormatter.getTMDBLanguageCode()

        let urlComponents = URLComponents(
            host: Constant.TMDBBaseUrl.rawValue,
            path: "/3/movie/popular",
            queryItems: [
                URLQueryItem(name: "language", value: language.rawValue),
                URLQueryItem(name: "api_key", value: Constant.TMDBApiKey.rawValue)
            ]
        )

        guard let url = urlComponents.url else {
            return Observable.empty()
        }

        print(url.absoluteString)
        return request(url.absoluteString)
    }

    func fetchMockingData() -> [Movie] {
        do {
            let path = Bundle.main.path(forResource: "data", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decodedData = try jsonDecoder.decode(JSONFile.self, from: data)

            return decodedData.movies
        } catch {
            return []
        }
    }

}
