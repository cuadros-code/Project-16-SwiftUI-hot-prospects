//
//  EditProspectView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 5/05/25.
//

import SwiftUI

struct EditProspectView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var prospectToEdit: Prospect
    
    @State private var name = ""
    @State private var emailAddress = ""
    
    var isValidForm: Bool {
        return name.isEmpty == false && emailAddress.isEmpty == false
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $emailAddress)
            HStack {
                Spacer()
                Button("Save") {
                    prospectToEdit.name = name
                    prospectToEdit.emailAddress = emailAddress
                    dismiss()
                }
                .disabled(!isValidForm)
                Spacer()
            }
        }
    }
    
    init(
        prospectToEdit: Prospect
    ) {
        self.prospectToEdit = prospectToEdit
        
        _name = State(initialValue: prospectToEdit.name)
        _emailAddress = State(initialValue: prospectToEdit.emailAddress)
    }
}

#Preview {
    EditProspectView(
        prospectToEdit: Prospect(name: "name to edit", emailAddress: "emailToEdit@gmail.com", isContacted: false)
    )
}
