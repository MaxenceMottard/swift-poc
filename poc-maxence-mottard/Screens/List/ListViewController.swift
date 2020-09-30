//
//  ListViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit

class ListViewController: UIViewController {
    
    var data: [Movie] = [] {
        didSet {
            dataTableView.reloadData()
        }
    }
    
    @IBOutlet var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        navigationController?.navigationBar.topItem?.title = "listViewTitle".localize()
        
        MovieDBApi.getMovies { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let movies):
                strongSelf.data = movies
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            fatalError("Could not dequeue cell with identifier : \(ListTableViewCell.reuseIdentifier)")
        }
        
        cell.movie = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = data[indexPath.row]
        
        let detailViewController = storyboard?.instantiateViewController(identifier: "detailViewController") as? DetailViewController
        
        guard let strongVC = detailViewController else {
            fatalError("Could not instanciate view controller with identifier : detailViewController")
        }
        
        strongVC.movie = movie
        
        navigationController?.pushViewController(strongVC, animated: true)
    }
}
