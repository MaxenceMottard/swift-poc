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
        
        container.autoregister(LocaleFormatter.self, initializer: LocaleFormatter.init)
        
        container.autoregister(JSONDecoder.self, initializer: JSONDecoder.init)
        
        container.register(PopularMovieRequest.self) { resolver -> PopularMovieRequest in
            let service = PopularMovieRequest()
            service.localeService = resolver.resolve(LocaleFormatter.self)
            service.jsonDecoder = resolver.resolve(JSONDecoder.self)
            
            return service
        }
        
        container.register(CustomDateFormater.self) { resolver -> CustomDateFormater in
            let service = CustomDateFormater()
            service.localeService = resolver.resolve(LocaleFormatter.self)
            
            return service
        }
        
        container.register(MovieRepository.self) { resolver -> MovieRepository in
            let repository = MovieRepository()
            repository.service = resolver.resolve(PopularMovieRequest.self)
            repository.mockingService = resolver.resolve(MockingService.self)
            
            return repository
        }
    }
}
