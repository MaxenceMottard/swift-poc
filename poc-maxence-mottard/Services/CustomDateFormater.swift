//
//  DateService.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 19/10/2020.
//

import Foundation

class CustomDateFormater {
    
    var localeService: LocaleFormatter!
    
    func convertToReadableDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = getFormat()
            return dateFormatter.string(from: date)
        }
        
        return dateString
    }
    
    private func getFormat() -> String {
        switch localeService.getCurrentLanguage() {
        case .fr:
            return "d MMMM yyyy"
        case .en:
            return "MMMM d, yyyy"
        }
    }
    
}
