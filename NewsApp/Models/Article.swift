//
//  Article.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Source: Codable, Equatable {
    let name: String
}

struct Article: Codable, Equatable {
    let source: Source

    let title: String
    let url: String
    let publishedAt: Date

    let author: String?
    let description: String?
    let urlToImage: String?

    var authorText: String {
        author ?? ""
    }

    var descriptionText: String {
        description ?? ""
    }

    var captionText: String {
        "\(source.name) · \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }

    var articleURL: URL {
        URL(string: url)!
    }

    var imageURL: URL? {
        guard let urlToImage else {
            return nil
        }

        return URL(string: urlToImage)
    }
}

extension Article: Identifiable {
    var id: String {
        url
    }
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)

        return apiResponse.articles ?? []
    }
}
