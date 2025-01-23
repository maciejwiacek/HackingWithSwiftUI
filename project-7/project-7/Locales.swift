//
//  Locales.swift
//  project-7
//
//  Created by Maciej Wiącek on 23/01/2025.
//

import Foundation

enum Locales {
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
