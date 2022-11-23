//
//  NewsAPIResponse.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?

    // Error Response
    let code: String?
    let message: String?
}
