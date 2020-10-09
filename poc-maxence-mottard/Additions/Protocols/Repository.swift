//
//  DataSourced.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype Entity
    associatedtype Service
    
    var data: BehaviorSubject<[Entity]> { get }
    var service: Service! { get }
    
    func getData()
}
