//
//  RetryView.swift
//  NewsApp
//
//  Created by Baher Tamer on 03/11/2022.
//

import SwiftUI

struct RetryView: View {

    let text: String
    let retryAction: () -> ()

    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)

            Button(action: retryAction) {
                Text("Try Again!")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "Error", retryAction: {})
    }
}
