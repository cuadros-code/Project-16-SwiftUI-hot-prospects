//
//  ContextMenuView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 17/04/25.
//

import SwiftUI

struct ContextMenuView: View {
    
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, Word")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(
                        "Red",
                        systemImage: "checkmark.circle.fill",
                        role: .destructive
                    ) {
                        backgroundColor = .red
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                }

        }
    }
}

#Preview {
    ContextMenuView()
}
