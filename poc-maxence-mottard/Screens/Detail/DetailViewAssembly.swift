//
//  DetailViewAssembly.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Swinject
import UIKit

final class DetailViewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DetailViewModelling.self) { (_: Resolver, model: DetailModel) -> DetailViewModelling in
            let viewModel = DetailViewModel()
            viewModel.model = model
            
            return viewModel
        }
        
        container.register(DetailViewController.self) { (resolver: Resolver, model: DetailModel) -> DetailViewController in
            let viewController = resolver.resolve(UIStoryboard.self)!.instantiateViewController(identifier: "detailViewController") as DetailViewController
            viewController.viewModel = resolver.resolve(DetailViewModelling.self, argument: model)
            viewController.dateFormatter = resolver.resolve(CustomDateFormater.self)
            
            return viewController
        }
    }
}
