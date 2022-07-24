//
//  Display+EditView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 24/07/2022.
//

import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var user: EnvironmentObjectView.User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    
    @EnvironmentObject var user: EnvironmentObjectView.User
    
    var body: some View {
        Text(user.name)
    }
}
