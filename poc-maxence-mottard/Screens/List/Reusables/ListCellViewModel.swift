//
//  ListCellViewModel.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 01/10/2020.
//

import Foundation

protocol ListCellViewModelling {
    var model: ListCellModel { get }
}

final class ListCellViewModel: ListCellViewModelling {
    let model: ListCellModel

    init(model: ListCellModel) {
        self.model = model
    }
}
