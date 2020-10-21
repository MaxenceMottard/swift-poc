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
    
    var data = BehaviorSubject<[Movie]>.init(value: [])
    var service: PopularMovieRequest!
    var mockingService: MockingService!
    let bag = DisposeBag()
    
    func fetchData() {
        if mockingService.getIsMocked() {
            data.onNext(service.fetchMockingData())
        } else {
            service.fetch().subscribe(onNext: { [weak self] requestResponse in
                guard let strongSelf = self else { return }
                strongSelf.data.onNext(requestResponse.results)
            }).disposed(by: bag)
        }
    }
}
