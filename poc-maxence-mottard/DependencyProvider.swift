//
//  AppContainer.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Foundation
import Swinject

class DependencyProvider {    
    let container: Container
    let assembler: Assembler
    
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
    
}
