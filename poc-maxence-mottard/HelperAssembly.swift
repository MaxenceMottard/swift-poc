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
        
        container.autoregister(MockingService.self, initializer: MockingService.init)
        
        container.autoregister(LocaleService.self, initializer: LocaleService.init)
        
        container.register(MovieDBApi.self) { resolver -> MovieDBApi in
            let service = MovieDBApi()
            service.localeService = resolver.resolve(LocaleService.self)
            
            return service
        }
        
        container.register(DateService.self) { resolver -> DateService in
            let service = DateService()
            service.localeService = resolver.resolve(LocaleService.self)
            
            return service
        }
        
        container.register(MovieRepository.self) { resolver -> MovieRepository in
            let repository = MovieRepository()
            repository.service = resolver.resolve(MovieDBApi.self)
            repository.mockingService = resolver.resolve(MockingService.self)
            
            return repository
        }
    }
}
