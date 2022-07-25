//
//  DelayedUpdaterContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI

struct DelayedUpdaterContentView: View {
    
    @StateObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct DelayedUpdaterContentView_Previews: PreviewProvider {
    static var previews: some View {
        DelayedUpdaterContentView()
    }
}
