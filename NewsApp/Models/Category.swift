//
//  Category.swift
//  NewsApp
//
//  Created by Baher Tamer on 02/11/2022.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health

    var text: String {
        if self == .general {
            return "Top Headlines"
        } else {
            return rawValue.capitalized
        }
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
