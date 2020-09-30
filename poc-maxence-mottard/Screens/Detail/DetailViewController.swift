//
//  DetailViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                guard let strongMovie = self.movie else { return }
                
                self.titleLabel.text = strongMovie.title
                self.descriptionLabel.text = strongMovie.description
                self.dateLabel.text = strongMovie.date
                
                let imageUrl = URL(string: strongMovie.imageUrl)
                let backgroundImageUrl = URL(string: strongMovie.backgroundImageUrl)
                
                if let url = imageUrl {
                    self.movieImageView.load(url: url)
                }
                
                if let url = backgroundImageUrl {
                    self.backgroundImageView.load(url: url)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = UIColor.white.cgColor
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
