//
//  AppContainer.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Foundation
import Swinject

class DependencyProvider {    
    private let container: Container
    private let assembler: Assembler
    
    init() {
        container = Container()
        
        assembler = Assembler([
            HelperAssembly(),
            ListViewAssembly(),
            DetailViewAssembly()
        ], container: container)
        
        container.register(DependencyProvider.self) { _ in
            return self
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return self.container.resolve(serviceType)
    }
    
    func resolve<Service, Argument>(_ serviceType: Service.Type, argument: Argument) -> Service? {
        return self.container.resolve(serviceType, argument: argument)
    }
}
