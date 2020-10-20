//
//  Setupable.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation

protocol Setupable {
    associatedtype Model
    
    func setup(with model: Model)
}
