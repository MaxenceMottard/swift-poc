//
//  ListViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit
import RxSwift

final class ListViewController: UIViewController {
    
    let viewModel: ListViewModelling = ListViewModel()
    let bag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        navigationController?.navigationBar.topItem?.title = "listViewTitle".localize()
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell, let movie = self.viewModel.getMovie(indexPath) else {
            fatalError("Could not dequeue cell with identifier : \(ListTableViewCell.reuseIdentifier)")
        }
        
        cell.viewModel.setMovie(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(identifier: "detailViewController") as? DetailViewController
        
        guard let strongVC = detailViewController, let movie = self.viewModel.getMovie(indexPath) else {
            fatalError("Could not instanciate view controller with identifier : detailViewController")
        }
        
        strongVC.viewModel.setMovie(movie)
        
        navigationController?.pushViewController(strongVC, animated: true)
    }
}
