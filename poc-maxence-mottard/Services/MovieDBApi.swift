//
//  MovieApi.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation
import Alamofire

class MovieDBApi {
    
    static let apiKey = "c5e559ac2b3964e6b8ddcc8b60df9bee"
    static let baseUrl = "https://api.themoviedb.org/3"
    
    
    enum PosterSizes {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSize {
        case w300, w780, w1280, original
    }
    
    static func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) -> Void {
        AF.request("\(MovieDBApi.baseUrl)/movie/popular?api_key=\(MovieDBApi.apiKey)").response { response in
            
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
    
    static func getImageUrl (posterPath: String, size: PosterSizes = .original) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(posterPath)")
    }
    
    static func getImageUrl (backdropPath: String, size: BackdropSize = .original) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(backdropPath)")
    }
    
}
