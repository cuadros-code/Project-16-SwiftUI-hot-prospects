//
//  ProspectsView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 28/04/25.
//

import SwiftUI

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("")
            .navigationTitle(title)
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
}
