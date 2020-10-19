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
    var dateService: DateService!
    
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
            strongSelf.dateLabel.text = strongSelf.dateService.convertToReadableDate(strongSelf.viewModel.model.releaseDate)
            
            if let url = strongSelf.viewModel.model.posterUrl {
                strongSelf.movieImageView.load(url: url)
            }
            
            if let url = strongSelf.viewModel.model.backdropUrl {
                strongSelf.backgroundImageView.load(url: url)
            }
        }
    }

}
