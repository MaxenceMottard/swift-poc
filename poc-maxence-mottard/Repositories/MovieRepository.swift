//
//  MovieRepository.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation
import RxSwift

final class MovieRepository: Repository {
    typealias Service = PopularMovieRequest
    typealias Entity = Movie

    var data = BehaviorSubject<[Movie]>(value: [])
    var service: PopularMovieRequest!
    var searchService: SearchMovieRequest!
    var mockingService: MockingService!
    let bag = DisposeBag()

    func fetchData(query: String? = nil) {
        if mockingService.getIsMocked() {
            data.onNext(service.fetchMockingData())
        } else {
            if let strongQuery = query {
                if !strongQuery.isEmpty {
                    searchService.fetch(strongQuery).subscribe(onNext: { [weak self] requestResponse in
                        guard let strongSelf = self else { return }
                        strongSelf.data.onNext(requestResponse.results)
                    }).disposed(by: bag)
                    return
                }
            }

            service.fetch().subscribe(onNext: { [weak self] requestResponse in
                guard let strongSelf = self else { return }
                strongSelf.data.onNext(requestResponse.results)
            }).disposed(by: bag)
        }
    }
}
