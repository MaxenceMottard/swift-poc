//
//  ListViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit
import RxSwift

final class ListViewController: UIViewController {
    
    var viewModel: ListViewModelling!
    var dependencyProvider: DependencyProvider!
    let bag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        navigationController?.navigationBar.topItem?.title = "listViewTitle".localize()
        
        bindingViewModel()
    }
    
    func bindingViewModel() {
        viewModel.movies.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.dataTableView.reloadData()
        }).disposed(by: bag)
        
        viewModel.requestMovies()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            fatalError("Could not dequeue cell with identifier : \(ListTableViewCell.reuseIdentifier)")
        }
        
        cell.setViewModel(viewModel.getCellViewModel(indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailModel = viewModel.getDetailModel(indexPath)
        let detailViewController = dependencyProvider.container.resolve(DetailViewController.self, argument: detailModel)!
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
