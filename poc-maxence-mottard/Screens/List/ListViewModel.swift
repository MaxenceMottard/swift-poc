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
    var movieRepository: MovieRepository! { get }
    var mockingService: MockingService! { get }
    
    func getNumberOfRows() -> Int
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
    internal var movieRepository: MovieRepository! {
        didSet {
            movieRepository.data.subscribe(onNext: { [weak self] movies in
                guard let strongSelf = self else { return }
                strongSelf.movies.onNext(movies)
            }).disposed(by: bag)
            
            movieRepository.getData()
        }
    }
    internal var mockingService: MockingService! {
        didSet {
            mockingService.getIsMockedSubject().subscribe(onNext: { [weak self] isMocked in
                guard let strongSelf = self else { return }
                
                strongSelf.movieRepository.getData()
                strongSelf.dataIsMocked.onNext(isMocked)
            }).disposed(by: bag)
        }
    }
    
    init() {
        movies.subscribe(onNext: { [weak self] movies in
            guard let strongSelf = self else { return }
            
            let detailModels = movies.map { DetailModel.from($0) }
            let listCellViewModels = movies.map { movie -> ListCellViewModel in
                //guard let strongSelf = self else { return }
                
                var model = ListCellModel.from(movie)
                //model.posterUrl = movieDBService.getImageUrl(posterPath: movie.posterPath, size: .w185)
                
                let viewModel = ListCellViewModel(model: model)
                
                return viewModel
            }
            
            strongSelf.numberOfRows = movies.count
            strongSelf.detailModels = detailModels
            strongSelf.listCellViewModels = listCellViewModels
        }).disposed(by: bag)
    }
    
    func getNumberOfRows() -> Int {
        return numberOfRows
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
