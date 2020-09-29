//
//  ReusableView.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 29/09/2020.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
