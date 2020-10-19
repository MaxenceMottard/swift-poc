//
//  MovieApi.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation
import Alamofire
import RxSwift

class MovieDBApi {
    
    enum PosterSizes {
        case w92, w154, w185, w342, w500, w780, original
    }
    
    enum BackdropSize {
        case w300, w780, w1280, original
    }
    
    var localeService: LocaleService!
    
    func getMovies() -> Observable<[Movie]> {
        return Observable<[Movie]>.create { [weak self] (observer) -> Disposable in
            guard let strongSelf = self else { return Disposables.create() }
            
            let language = strongSelf.localeService.getTMDBLanguageCode()
            let requestReference = AF.request("\(Constant.TMDBBaseUrl.rawValue)/movie/popular?language=\(language)&api_key=\(Constant.TMDBApiKey.rawValue)").response { response in
                
                do {
                    if let data = response.value {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(MoviesRequest.self, from: data!)
                        
                        observer.onNext(decodedData.results)
                        observer.onCompleted()
                    } else if let error = response.error {
                        observer.onError(error)
                    }
                } catch let error {
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                requestReference.cancel()
            }
        }
    }
    
    func getMockingMovies() -> [Movie] {
        do {
            let path = Bundle.main.path(forResource: "data", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(JSONFile.self, from: data)
            
            return decodedData.movies
        } catch {
            return []
        }
    }
    
}
