//
//  HelperAssembly.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Swinject
import UIKit

class HelperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UIStoryboard.self) { _ -> UIStoryboard in
            return UIStoryboard(name: "Main", bundle: nil)
        }
        
        container.register(DependencyProvider.self) { _ in
            return DependencyProvider()
        }
        
        container.register(MovieDBApi.self) { _ in
            return MovieDBApi()
        }
    }
}
