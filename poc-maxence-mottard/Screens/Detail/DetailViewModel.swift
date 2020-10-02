//
//  DetailViewModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation

protocol DetailViewModelling {
    var model: DetailModel { get }
}

final class DetailViewModel: DetailViewModelling {
    let model: DetailModel
    
    init(detailModel: DetailModel) {
        self.model = detailModel
    }
}
