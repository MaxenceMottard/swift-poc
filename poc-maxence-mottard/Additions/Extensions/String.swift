//
//  String.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 30/09/2020.
//

import Foundation

extension String {
    
    func localize(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
