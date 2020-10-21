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
        let url = "\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)"
        return request(url)
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
