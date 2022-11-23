//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import SwiftUI

@main
struct NewsAppApp: App {

    @StateObject var articleBookmarkViewModel = ArticleBookmarkViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.articleBookmarkViewModel)
        }
    }
}
