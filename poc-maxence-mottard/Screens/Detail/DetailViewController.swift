//
//  DetailViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    let viewModel: DetailViewModelling = DetailViewModel()
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                guard let strongMovie = self.movie else { return }
                
                self.titleLabel.text = strongMovie.title
                self.descriptionLabel.text = strongMovie.overview
                self.dateLabel.text = strongMovie.releaseDate
                
                let imageUrl = MovieDBApi.getImageUrl(posterPath: strongMovie.posterPath, size: .w185)
                
                // Get image with different size according to device type
                let backdropSize = UIDevice.current.userInterfaceIdiom == .pad ? MovieDBApi.BackdropSize.w780 : MovieDBApi.BackdropSize.w1280
                let backgroundImageUrl = MovieDBApi.getImageUrl(backdropPath: strongMovie.backdropPath, size: backdropSize)
                
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
        
        viewModel.movie.subscribe(onNext: { movie in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self, let strongMovie = movie else { return }
                
                strongSelf.titleLabel.text = strongMovie.title
                strongSelf.descriptionLabel.text = strongMovie.overview
                strongSelf.dateLabel.text = strongMovie.releaseDate
                
                let imageUrl = MovieDBApi.getImageUrl(posterPath: strongMovie.posterPath, size: .w185)
                
                // Get image with different size according to device type
                let backdropSize = UIDevice.current.userInterfaceIdiom == .pad ? MovieDBApi.BackdropSize.w780 : MovieDBApi.BackdropSize.w1280
                let backgroundImageUrl = MovieDBApi.getImageUrl(backdropPath: strongMovie.backdropPath, size: backdropSize)
                
                if let url = imageUrl {
                    strongSelf.movieImageView.load(url: url)
                }
                
                if let url = backgroundImageUrl {
                    strongSelf.backgroundImageView.load(url: url)
                }
            }
        }).disposed(by: viewModel.bag)
    }

}
