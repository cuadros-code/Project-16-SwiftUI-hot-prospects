//
//  AddPackageDependenciesView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 24/04/25.
//

import SwiftUI
import SamplePackage

struct AddPackageDependenciesView: View {
    
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    AddPackageDependenciesView()
}
