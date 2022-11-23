//
//  ContentView.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            SearchTabView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
