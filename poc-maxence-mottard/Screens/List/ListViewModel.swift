//
//  ListViewModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation
import RxSwift

protocol ListViewModelling {
    var bag: DisposeBag { get }
    var movies: BehaviorSubject<[Movie]> { get }
    var numberOfRows: Int { get set }
    
    func getNumberOfRows() -> Int
    func requestMovies() -> Void
    func getMovie(_ index: IndexPath) -> Movie?
}

final class ListViewModel: ListViewModelling {
    internal var numberOfRows: Int = 0
    internal let movies: BehaviorSubject<[Movie]> = BehaviorSubject<[Movie]>.init(value: [])
    let bag = DisposeBag()
    
    init() {
        movies.subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.numberOfRows = movies.count
        }).disposed(by: bag)
    }
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
    
    func requestMovies() {
        MovieDBApi.getMovies().subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.movies.onNext(movies)
        }).disposed(by: bag)
    }
    
    func getMovie(_ index: IndexPath) -> Movie? {
        do {
            return try self.movies.value()[index.row]
        } catch {
            return nil
        }
    }
}
