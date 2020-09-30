//
//  DetailViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                guard let _ = self.movie else { return }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
