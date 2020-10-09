//
//  HelperAssembly.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Swinject
import SwinjectAutoregistration
import UIKit

class HelperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UIStoryboard.self) { _ -> UIStoryboard in
            return UIStoryboard(name: "Main", bundle: nil)
        }
        
        container.register(MockingService.self) { _ in
            return MockingService()
        }
        
        container.autoregister(MovieDBApi.self, initializer: MovieDBApi.init)
    }
}
