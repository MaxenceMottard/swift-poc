//
//  ListViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit

class ListViewController: UITableViewController {
    
    let data: [Movie] = [
        Movie(title: "Joker", description: "Lorem Ipsum", imageUrl: "https://cdn.radiofrance.fr/s3/cruiser-production/2019/08/f67ac277-eae3-4ae0-96e3-3efb2751b573/600_edkfeikxyaegb5i.jpg"),
        Movie(title: "Interstellar", description: "Lorem Ipsum", imageUrl: "https://imgr.cineserie.com/2020/02/ob_f276dc_interstellar.png?imgeng=/f_jpg/cmpr_0/w_1121/h_1600/m_cropbox&ver=1")
    ]
    
    @IBOutlet var dataTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath)

        cell.textLabel?.text = "Row \(indexPath.row)"

        return cell
    }

}