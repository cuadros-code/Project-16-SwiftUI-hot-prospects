//
//  ProspectsView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 28/04/25.
//

import SwiftUI
import SwiftData
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @State private var sortOrder = [
        SortDescriptor(\Prospect.name)
    ]    
    
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
                            // addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Prospect.name)
                                ])
                            
                            Text("Sort by Email")
                                .tag([
                                    SortDescriptor(\Prospect.emailAddress)
                                ])
                        }
                    }
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Tom hatson\ntomhatson@hotmail.com",
                    completion: handleScan
                )
            }
            .navigationDestination(for: Prospect.self) { prospect in
                EditProspectView(prospectToEdit: prospect)
            }
            
        }
    }
    
    
    init(filter: FilterType) {
        self.filter = filter
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(
                name: details[0],
                emailAddress: details[1],
                isContacted: false
            )
            modelContext.insert(person)
            
        case .failure(let failure):
            print("Scanning failed \(failure.localizedDescription)")
        }
        
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //
            //            let trigger = UNCalendarNotificationTrigger(
            //                dateMatching: dateComponents,
            //                repeats: false
            //            )
            
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5,
                repeats: false
            )
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else  {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { ok, err in
                    if ok {
                        addRequest()
                    } else if let err {
                        print(err.localizedDescription)
                    }
                }
            }
        }
        
        
    }
    
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
