//
//  MovieApi.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation
import Alamofire

class MovieDBApi {
    
    enum PosterSizes {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSize {
        case w300, w780, w1280, original
    }
    
    static func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) -> Void {
        let language = Locale.current.languageCode == "fr" ? "fr-FR" : "en-US"
        AF.request("\(Constant.TMDBBaseUrl)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey)").response { response in
            
            do {
                if let data = response.value {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(MoviesRequest.self, from: data!)
                    completion(.success(decodedData.results))
                } else if let error = response.error {
                    completion(.failure(error))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    static func getImageUrl(posterPath: String, size: PosterSizes = .original) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(posterPath)")
    }
    
    static func getImageUrl(backdropPath: String, size: BackdropSize = .original) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(backdropPath)")
    }
    
}
