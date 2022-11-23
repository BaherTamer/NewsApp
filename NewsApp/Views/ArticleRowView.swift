//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Baher Tamer on 30/10/2022.
//

import SwiftUI

struct ArticleRowView: View {

    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel

    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.25))
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)

                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)

                HStack {
                    Text(article.captionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)

                    Spacer()

                    Group {
                        Button {
                            toggleBookmark(for: article)
                        } label: {
                            Image(systemName: articleBookmarkViewModel.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                        }

                        Button {
                            presentShareSheet(url: article.articleURL)
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .buttonStyle(.bordered)

                }
            }
            .padding([.horizontal, .bottom])
        }
    }

    private func toggleBookmark(for article: Article) {
        if articleBookmarkViewModel.isBookmarked(for: article) {
            articleBookmarkViewModel.removeBookmark(for: article)
        } else {
            articleBookmarkViewModel.addBookmark(for: article)
        }
    }
}

extension View {
    func presentShareSheet(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityViewController, animated: true)
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: .previewData[1])
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
