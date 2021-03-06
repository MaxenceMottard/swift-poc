//
//  ListViewAssembly.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Swinject
import UIKit

final class ListViewAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ListViewModel.self) { (resolver: Resolver) -> ListViewModel in
            let viewModel = ListViewModel()
            viewModel.movieRepository = resolver.resolve(MovieRepository.self)!
            viewModel.mockingService = resolver.resolve(MockingService.self)!
            viewModel.bindingAfterSetup()

            return viewModel
        }

        container.register(ListViewController.self) { (resolver: Resolver) -> ListViewController in
            let viewControler = resolver.resolve(UIStoryboard.self)!.instantiateViewController(identifier: "listViewController") as ListViewController

            viewControler.viewModel = resolver.resolve(ListViewModel.self)
            viewControler.dependencyProvider = resolver.resolve(DependencyProvider.self)

            return viewControler
        }
    }

}
