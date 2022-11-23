//
//  SearchHistoryListView.swift
//  NewsApp
//
//  Created by Baher Tamer on 23/11/2022.
//

import SwiftUI

struct SearchHistoryListView: View {

    @ObservedObject var articleSearchViewModel: ArticleSearchViewModel
    let onSubmit: (String) -> ()

    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button("Clear") {
                    articleSearchViewModel.removeAllHistory()
                }
                .foregroundColor(.accentColor)
            }
            .listRowSeparator(.hidden)

            ForEach(articleSearchViewModel.history, id: \.self) { history in
                Button(history) {
                    onSubmit(history)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        articleSearchViewModel.removeHistory(history)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(articleSearchViewModel: ArticleSearchViewModel.shared) { _ in

        }
    }
}
