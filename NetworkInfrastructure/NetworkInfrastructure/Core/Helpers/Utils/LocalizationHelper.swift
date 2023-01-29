//
//  LocalizationHelper.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

enum Language: String {
    case english = "en"
    case spanish = "es"
}

struct LocalizationHelper {

    static let defaultLanguage: Language = .english

    static func getCurrentLanguageCode() -> String {
        guard let languageCode = Locale.current.languageCode else {
            return defaultLanguage.rawValue
        }
        return Language.init(rawValue: languageCode)?.rawValue ?? defaultLanguage.rawValue
    }

}
