//
//  ApiRequest.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 20/10/2020.
//

import Foundation
import RxSwift
import Alamofire

protocol ApiRequest {
    associatedtype ResultType: Decodable

    var jsonDecoder: JSONDecoder! { get set }

    func fetch() -> Observable<ResultType>
    func request(_ url: String) -> Observable<ResultType>
}

extension ApiRequest {
    func request(_ url: String) -> Observable<ResultType> {
        return Observable<ResultType>.create { observer -> Disposable in
            let requestReference = AF.request(url).response { response in
                do {
                    if let data = response.value {
                        observer.onNext(try jsonDecoder.decode(ResultType.self, from: data!))
                    } else {
                        throw response.error!
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
}
