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
    var localeService: LocaleService!
    
    enum PosterSizes {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSize {
        case w300, w780, w1280, original
    }
    
    var localeService: LocaleFormatter!
    
    func fetch() -> Observable<MoviesRequest> {
        let language = localeService.getTMDBLanguageCode()
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
