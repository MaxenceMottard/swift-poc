//
//  ListTableViewCell.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit

class ListTableViewCell: UITableViewCell, ReusableView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var movieImageView : UIImageView!
    
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                guard let strongMovie = self.movie else { return }
                self.titleLabel.text = strongMovie.title
                self.descriptionLabel.text = strongMovie.description
                
                let imageUrl = URL(string: strongMovie.imageUrl)
                
                if let url = imageUrl {
                    self.movieImageView.load(url: url)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
