//
//  MovieRepository.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation
import RxSwift

final class MovieRepository: Repository {
    typealias Service = MovieDBApi
    typealias Entity = Movie
    
    var data = BehaviorSubject<[Movie]>.init(value: [])
    var service: MovieDBApi!
    let bag = DisposeBag()
    
    func getData() {
        service.getMovies().subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.data.onNext(movies)
        }).disposed(by: bag)
    }
}
