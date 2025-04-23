//
//  SwipeActionRowView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 22/04/25.
//

import SwiftUI

struct SwipeActionRowView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(
                        "Delete",
                        systemImage: "minus.circle",
                        role: .destructive
                    ) {
                        print("Delete")
                    }
                    
                }
                .swipeActions(edge: .leading) {
                    Button("Send Message", systemImage: "message") {
                        print("Hi")
                    }
                    .tint(.accentColor)
                }
        }
    }
}

#Preview {
    SwipeActionRowView()
}
