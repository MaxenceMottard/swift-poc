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
    
    private var mockButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        mockButton = UIBarButtonItem(image: UIImage(systemName: "antenna.radiowaves.left.and.right"), style: .done, target: self, action: #selector(handleMockData))
        
        navigationController?.navigationBar.topItem?.title = "listViewTitle".localize()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = mockButton
        
        bindingViewModel()
    }
    
    @objc func handleMockData() {
        viewModel.toggleDataIsMocked()
    }
    
    func bindingViewModel() {
        viewModel.movies.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.dataTableView.reloadData()
        }).disposed(by: bag)
        
        viewModel.dataIsMocked.subscribe(onNext: { [weak self] isMocked in
            guard let strongSelf = self else { return }
            
            strongSelf.mockButton.tintColor = isMocked ? UIColor.red : UIColor.green
        }).disposed(by: bag)
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
        
        cell.setup(with: viewModel.getCellViewModel(indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailModel = viewModel.getDetailModel(indexPath)
        let detailViewController = dependencyProvider.resolve(DetailViewController.self, argument: detailModel)!
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
