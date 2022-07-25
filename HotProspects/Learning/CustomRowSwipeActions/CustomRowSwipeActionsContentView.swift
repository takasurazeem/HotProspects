//
//  CustomRowSwipeActionsContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI

struct CustomRowSwipeActionsContentView: View {
    var body: some View {
        List {
            Text("Takasur Azeem")
                .swipeActions {
                    Button {
                        print("Salam!")
                    } label: {
                        Label("Send message", systemImage: "message")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Salam!")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct CustomRowSwipeActionsContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRowSwipeActionsContentView()
    }
}
