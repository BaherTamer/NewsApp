//
//  SearchTabView.swift
//  NewsApp
//
//  Created by Baher Tamer on 23/11/2022.
//

import SwiftUI

struct SearchTabView: View {

    @StateObject private var articleSearchViewModel = ArticleSearchViewModel.shared

    private var articles: [Article] {
        if case .success(let articles) = articleSearchViewModel.phase {
            return articles
        } else {
            return []
        }
    }

    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .navigationTitle("Search")
        }
        .searchable(text: $articleSearchViewModel.searchQuery) { suggestionsView }
        .onChange(of: articleSearchViewModel.searchQuery) { newValue in
            if newValue.isEmpty {
                articleSearchViewModel.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
    }

    @ViewBuilder
    private var overlayView: some View {
        switch articleSearchViewModel.phase {
        case .empty:
            if !articleSearchViewModel.searchQuery.isEmpty {
                ProgressView()
            } else if !articleSearchViewModel.history.isEmpty {
                SearchHistoryListView(articleSearchViewModel: articleSearchViewModel) { newValue in
                    articleSearchViewModel.searchQuery = newValue
                    search()
                }
            } else {
                EmptyPlaceholderView(text: "Search for an article", image: Image(systemName: "magnifyingglass"))
            }

        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search results", image: Image(systemName: "magnifyingglass"))

        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)

        default: EmptyView()
        }
    }

    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS 15"], id: \.self) { text in
            Button {
                articleSearchViewModel.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }

    private func search() {
        let searchQuery = articleSearchViewModel.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            articleSearchViewModel.addHistory(searchQuery)
        }

        Task {
            await articleSearchViewModel.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
