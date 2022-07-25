//
//  TabViewLearning.swift
//  HotProspects
//
//  Created by Takasur Azeem on 24/07/2022.
//

import SwiftUI

struct TabViewLearning: View {

    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

struct TabViewLearning_Previews: PreviewProvider {
    static var previews: some View {
        TabViewLearning()
            .preferredColorScheme(.dark)
    }
}
