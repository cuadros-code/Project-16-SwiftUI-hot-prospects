//
//  ProspectsListView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 9/05/25.
//

import SwiftUI
import SwiftData

struct ProspectsListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    
    var body: some View {
        List(prospects) { prospect in
            NavigationLink(value: prospect) {
                ProspectListItem(prospect: prospect)
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                
                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
//                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            .tag(prospect)
        }
    }
    
    init(filter: FilterType,  sort: [SortDescriptor<Prospect>]) {
        
        print(sort)
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sort)
        }
    }
}

#Preview {
    ProspectsListView(
        filter: .uncontacted,
        sort: [SortDescriptor(\Prospect.name)]
    )
}
