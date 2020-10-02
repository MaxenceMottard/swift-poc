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
    var detailModels: [DetailModel] { get set }
    var listCellViewModels: [ListCellViewModel] { get set }
    
    func getNumberOfRows() -> Int
    func requestMovies() -> Void
    func getDetailModel(_ index: IndexPath) -> DetailModel
    func getCellViewModel(_ index: IndexPath) -> ListCellViewModelling
}

final class ListViewModel: ListViewModelling {
    internal var numberOfRows: Int = 0
    internal let movies: BehaviorSubject<[Movie]> = BehaviorSubject<[Movie]>.init(value: [])
    internal let bag = DisposeBag()
    internal var detailModels: [DetailModel] = []
    internal var listCellViewModels: [ListCellViewModel] = []
    
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
        MovieDBApi.getMovies().subscribe(onNext: { [weak self] movies in
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
}
