//
//  ProspectListItem.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 5/05/25.
//

import SwiftUI

struct ProspectListItem: View {
    
    let prospect: Prospect
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(prospect.name)
                    .font(.headline)
                if prospect.isContacted {
                    Image(systemName: "person.fill.checkmark")
                        .font(.caption)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "person.fill.xmark")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            Text(prospect.emailAddress)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProspectListItem(prospect: Prospect(
        name: "Test name",
        emailAddress: "emailTest@gmail.com",
        isContacted: false
    ))
}
