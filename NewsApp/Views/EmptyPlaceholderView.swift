//
//  EmptyPlaceholderView.swift
//  NewsApp
//
//  Created by Baher Tamer on 03/11/2022.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?

    var body: some View {
        VStack(spacing: 8) {
            Spacer()

            if let image {
                image
                    .imageScale(.large)
                    .font(.system(size: 50))
            }

            Text(text)

            Spacer()
        }
    }
}

struct EmptyPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholderView(text: "No Bookmarks", image: Image(systemName: "bookmark"))
    }
}
