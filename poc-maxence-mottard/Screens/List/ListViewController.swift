//
//  ListViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit

class ListViewController: UIViewController {
    
    let data: [Movie] = [
        Movie(title: "Joker",
              description: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
              imageUrl: "https://cdn.radiofrance.fr/s3/cruiser-production/2019/08/f67ac277-eae3-4ae0-96e3-3efb2751b573/600_edkfeikxyaegb5i.jpg",
              backgroundImageUrl: "https://www.journaldugeek.com/content/uploads/2019/10/4765874-r-1920-1080-f-jpg-q-x-xxyxxx-640x425.jpg",
              date: "2019-10-09"),
        Movie(title: "Interstellar",
              description: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
              imageUrl: "https://imgr.cineserie.com/2020/02/ob_f276dc_interstellar.png?imgeng=/f_jpg/cmpr_0/w_1121/h_1600/m_cropbox&ver=1",
              backgroundImageUrl: "https://www.slate.fr/sites/default/files/styles/1060x523/public/paramount.jpg",
              date: "2014-11-05")
    ]
    
    @IBOutlet var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
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
