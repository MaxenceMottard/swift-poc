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
    var dateFormatter: CustomDateFormater!

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    private var shareButton: UIBarButtonItem!

    private let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "backButtonTitle".localize()

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        movieImageView.layer.borderWidth = 1
        movieImageView.layer.borderColor = UIColor.white.cgColor

        shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(handleShareMovie))

        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        setupView()
    }

    func setupView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.navigationController?.navigationBar.topItem?.title = strongSelf.viewModel.model.title
            strongSelf.navigationController?.navigationBar.topItem?.rightBarButtonItem = strongSelf.shareButton

            strongSelf.titleLabel.text = strongSelf.viewModel.model.title
            strongSelf.descriptionLabel.text = strongSelf.viewModel.model.overview
            strongSelf.dateLabel.text = strongSelf.dateFormatter.convertToReadableDate(strongSelf.viewModel.model.releaseDate)

            if let url = strongSelf.viewModel.model.posterUrl {
                strongSelf.movieImageView.load(url: url)
            }

            let backdropUrl = UIDevice.current.userInterfaceIdiom == .pad
                ? strongSelf.viewModel.model.backdropPadUrl
                : strongSelf.viewModel.model.backdropPhoneUrl

            if let url = backdropUrl {
                strongSelf.backgroundImageView.load(url: url)
            }
        }
    }

    @objc func handleShareMovie() {
        guard let posterOriginalUrl = viewModel.model.posterOriginalUrl,
              let data = try? Data(contentsOf: posterOriginalUrl),
              let image = UIImage(data: data)  else { return }

        let items: [Any] = [viewModel.model.title, image, posterOriginalUrl.absoluteURL]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    }
}
