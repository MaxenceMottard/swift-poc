//
//  LocaleService.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 19/10/2020.
//

import Foundation

class LocaleService {
    enum TMDBLanguage: String {
        case fr = "fr-FR"
        case en = "en-US"
    }
    
    enum SupportedLanguage: String {
        case fr, en
    }
    
    private let currentLocale = Locale.current
    private var currentLanguage = SupportedLanguage.en
    
    init() {
        self.currentLanguage = self.getCurrentLanguage()
    }
    
    func getTMDBLanguageCode() -> TMDBLanguage {
        switch currentLanguage {
        case .fr:
            return .fr
        case .en:
            return .en
        }
    }
    
    func getCurrentLanguage() -> SupportedLanguage {
        switch currentLocale.languageCode {
        case "fr":
            return .fr
        default:
            return .en
        }
    }
    
}
