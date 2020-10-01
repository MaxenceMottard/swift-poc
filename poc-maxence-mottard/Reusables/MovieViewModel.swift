//
//  ListCellViewModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation
import RxSwift

protocol MovieViewModelling {
    var bag: DisposeBag { get }
    var movie: BehaviorSubject<Movie?> { get }
    
    func setMovie(_ movie: Movie) -> Void
}

class MovieViewModel: MovieViewModelling {
    let bag: DisposeBag = DisposeBag()
    let movie: BehaviorSubject<Movie?> = BehaviorSubject<Movie?>(value: nil)
    
    func setMovie(_ movie: Movie) {
        self.movie.onNext(movie)
    }
}
