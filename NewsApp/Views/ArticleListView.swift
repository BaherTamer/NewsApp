//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import SwiftUI

struct ArticleListView: View {

    let articles: [Article]

    @State private var selectedArticle: Article?

    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
