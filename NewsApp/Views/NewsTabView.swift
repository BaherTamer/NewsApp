//
//  NewsTabView.swift
//  NewsApp
//
//  Created by Baher Tamer on 03/11/2022.
//

import SwiftUI

struct NewsTabView: View {

    @StateObject var articlesNewsViewModel = ArticleNewsViewModel()

    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .navigationTitle(articlesNewsViewModel.fetchTaskToken.category.text)
                .overlay(overlayView)
                .task(id: articlesNewsViewModel.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .toolbar {
                    menu
                }
        }
    }

    @ViewBuilder
    private var overlayView: some View {
        switch articlesNewsViewModel.phase {

        case .empty:
            ProgressView()

        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Articles", image: nil)

        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)

        default:
            EmptyView()
        }
    }

    private var articles: [Article] {
        if case let .success(articles) = articlesNewsViewModel.phase {
            return articles
        } else {
            return []
        }
    }

    private var menu: some View {
        Menu {
            Picker("Category", selection: $articlesNewsViewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text)
                        .tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }

    @Sendable
    private func loadTask() async {
        await articlesNewsViewModel.loadArticles()
    }

    private func refreshTask() {
        DispatchQueue.main.async {
            articlesNewsViewModel.fetchTaskToken = FetchTaskToken(category: articlesNewsViewModel.fetchTaskToken.category, token: Date())
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articlesNewsViewModel: ArticleNewsViewModel(articles: Article.previewData))
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
