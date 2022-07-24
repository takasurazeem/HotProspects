//
//  EnvironmentObjectView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 24/07/2022.
//

import SwiftUI

struct EnvironmentObjectView: View {
    
    @StateObject var user = EnvironmentObjectView.User()
    
    var body: some View {
        VStack {
            EditView()
                .padding()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct EnvironmentObjectView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectView()
            .preferredColorScheme(.dark)
    }
}
