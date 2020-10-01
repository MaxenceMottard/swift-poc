//
//  ListTableViewCell.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit

final class ListTableViewCell: UITableViewCell, ReusableView {
    
    let viewModel: ListCellViewModelling = ListCellViewModel()
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var movieImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        viewModel.movie.subscribe(onNext: { movie in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self, let strongMovie = strongSelf.viewModel.getMovie() else { return }
                strongSelf.titleLabel.text = strongMovie.title
                strongSelf.descriptionLabel.text = strongMovie.overview
                
                let imageUrl = MovieDBApi.getImageUrl(posterPath: strongMovie.posterPath, size: .w185)
                
                if let url = imageUrl {
                    strongSelf.movieImageView.load(url: url)
                }
            }
        }).disposed(by: viewModel.bag)
        // Configure the view for the selected state
    }
    
}
