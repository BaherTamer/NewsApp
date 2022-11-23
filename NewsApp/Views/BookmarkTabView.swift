//
//  BookmarkTabView.swift
//  NewsApp
//
//  Created by Baher Tamer on 19/11/2022.
//

import SwiftUI

struct BookmarkTabView: View {

    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    @State private var searchText: String = ""

    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkViewModel.bookmarks
        } else {
            return articleBookmarkViewModel.bookmarks.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        let articles = self.articles

        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }

    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No save articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
