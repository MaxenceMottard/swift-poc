//
//  ListTableViewCell.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import UIKit
import RxSwift

final class ListTableViewCell: UITableViewCell, ReusableView, Setupable {
    typealias Model = ListCellViewModelling
    
    var viewModel: ListCellViewModelling?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with model: ListCellViewModelling) {
        self.viewModel = model
        setupView()
    }
    
    func setupView() {
        guard let vModel = viewModel else { return }
        
        titleLabel.text = vModel.model.title
        descriptionLabel.text = vModel.model.overview
        
        if let url = vModel.model.posterUrl {
            movieImageView.load(url: url)
        }
    }
    
}
