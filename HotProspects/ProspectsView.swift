//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    struct SortChoice: Hashable {
        let name: String
        let icon: String
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    @State private var filteredProspects: [Prospect] = []
    
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    
    let sortByChoices = [SortChoice(name: "Name", icon: "textformat.abc"), SortChoice(name: "Date Added", icon: "calendar.badge.clock")]
    @State private var selection: SortChoice
    
    init(filter: FilterType) {
        self.filter = filter
        _selection = State(wrappedValue: sortByChoices.first!)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if filter == .none, prospect.isContacted {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .foregroundColor(.green)
                        } else if filter == .none && !prospect.isContacted {
                            Image(systemName: "person.crop.circle.badge.xmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotificaiton(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .onAppear(perform: updatePerspectives)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Text("Sorted by")
                        Picker("Sorted by", selection: $selection) {
                            ForEach(sortByChoices, id: \.self) { choice in
                                Label("\(choice.name)", systemImage: "\(choice.icon)")
                            }
                        }.onChange(of: selection, perform: sortPerspectives(newSelection:))
                    } label: {
                        Label("Filter", systemImage: "arrow.up.arrow.down.square")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Takasur Azeem\ntakasurazeem@gmail.com", completion: handleScan(result:))
            }
        }
    }

    private func updatePerspectives() {
        switch filter {
        case .none:
            filteredProspects = prospects.people
        case .contacted:
            filteredProspects = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            filteredProspects = prospects.people.filter { !$0.isContacted }
        }
    }

    func sortPerspectives(newSelection: SortChoice) {
        if newSelection == sortByChoices.first {
            filteredProspects = filteredProspects.sorted { $0.name < $1.name }
        } else {
            filteredProspects =  filteredProspects.sorted { $0.dateAdded < $1.dateAdded }
        }
    }
    
    func addNotificaiton(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let scanResult):
            let details = scanResult.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
            updatePerspectives()
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
            .preferredColorScheme(.dark)
    }
}
