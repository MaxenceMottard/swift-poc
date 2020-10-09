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
    var dataIsMocked: BehaviorSubject<Bool> { get }
    var numberOfRows: Int { get set }
    var detailModels: [DetailModel] { get set }
    var listCellViewModels: [ListCellViewModel] { get set }
    var movieDBService: MovieDBApi! { get }
    var mockingService: MockingService! { get }
    
    func getNumberOfRows() -> Int
    func requestMovies() -> Void
    func toggleDataIsMocked() -> Void
    func getDetailModel(_ index: IndexPath) -> DetailModel
    func getCellViewModel(_ index: IndexPath) -> ListCellViewModelling
}

final class ListViewModel: ListViewModelling {
    internal let bag = DisposeBag()
    internal var numberOfRows: Int = 0
    internal let movies = BehaviorSubject<[Movie]>.init(value: [])
    internal let dataIsMocked = BehaviorSubject<Bool>.init(value: false)
    internal var detailModels: [DetailModel] = []
    internal var listCellViewModels: [ListCellViewModel] = []
    internal var movieDBService: MovieDBApi!
    internal var mockingService: MockingService! {
        didSet {
            mockingService.getIsMockedSubject().subscribe(onNext: { [weak self] isMocked in
                guard let strongSelf = self else { return }
                
                strongSelf.requestMovies()
                strongSelf.dataIsMocked.onNext(isMocked)
            }).disposed(by: bag)
        }
    }
    
    init() {
        movies.subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            
            let detailModels = movies.map { DetailModel.from($0) }
            let listCellViewModels = movies.map { ListCellViewModel(model: ListCellModel.from($0)) }
            
            strongSelf.numberOfRows = movies.count
            strongSelf.detailModels = detailModels
            strongSelf.listCellViewModels = listCellViewModels
        }).disposed(by: bag)
    }
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
    
    func requestMovies() {
        movieDBService.getMovies().subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.movies.onNext(movies)
        }).disposed(by: bag)
    }
    
    func getDetailModel(_ index: IndexPath) -> DetailModel {
        return detailModels[index.row]
    }
    
    func getCellViewModel(_ index: IndexPath) -> ListCellViewModelling {
        return listCellViewModels[index.row]
    }
    
    func toggleDataIsMocked() {
        mockingService.toggleIsMocked()
    }
}
