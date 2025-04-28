//
//  ContentView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 14/04/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Everyone", systemImage: "person.3") {
                ProspectsView(filter: .none)
            }
            Tab("Contacted", systemImage: "checkmark.circle") {
                ProspectsView(filter: .contacted)
            }
            Tab("Uncontacted", systemImage: "questionmark.diamond") {
                ProspectsView(filter: .uncontacted)
            }
            Tab("Me", systemImage: "person.crop.square") {
                MeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
