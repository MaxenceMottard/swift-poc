//
//  AppContainer.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 02/10/2020.
//

import Foundation
import Swinject

class DependencyProvider {
    
    static var shared = DependencyProvider()
    
    let container: Container
    let assembler: Assembler
    
    init() {
        container = Container()
        
        assembler = Assembler([
            HelperAssembly(),
            ListViewAssembly(),
            DetailViewAssembly()
        ], container: container)
    }
    
}
