//
//  ListView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 14/04/25.
//

import SwiftUI

struct ListView: View {
    
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection: String?
    @State private var multipleSelection = Set<String>()
    
    var body: some View {
        
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        List(users, id: \.self, selection: $multipleSelection) { user in
            Text(user)
        }
        
        if let selection {
            Text("Your selected \(selection)")
        }
        if multipleSelection.isEmpty == false {
            Text("Your selected \(multipleSelection.formatted())")
        }
        
        EditButton()
    }
    
}

#Preview {
    ListView()
}
