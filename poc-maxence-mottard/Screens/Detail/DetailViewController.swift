//
//  DetailViewController.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {

    var viewModel: DetailViewModelling!
    var movieDBApi: MovieDBApi!
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "backButtonTitle".localize()
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = UIColor.white.cgColor
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        setupView()
    }
    
    func setupView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.navigationController?.navigationBar.topItem?.title = strongSelf.viewModel.model.title
            
            strongSelf.titleLabel.text = strongSelf.viewModel.model.title
            strongSelf.descriptionLabel.text = strongSelf.viewModel.model.overview
            strongSelf.dateLabel.text = strongSelf.viewModel.model.releaseDate
            
            let imageUrl = strongSelf.movieDBApi.getImageUrl(posterPath: strongSelf.viewModel.model.posterPath, size: .w185)
            
            // Get image with different size according to device type
            let backdropSize = UIDevice.current.userInterfaceIdiom == .pad ? MovieDBApi.BackdropSize.w780 : MovieDBApi.BackdropSize.w1280
            let backgroundImageUrl = strongSelf.movieDBApi.getImageUrl(backdropPath: strongSelf.viewModel.model.backdropPath, size: backdropSize)
            
            if let url = imageUrl {
                strongSelf.movieImageView.load(url: url)
            }
            
            if let url = backgroundImageUrl {
                strongSelf.backgroundImageView.load(url: url)
            }
        }
    }

}
