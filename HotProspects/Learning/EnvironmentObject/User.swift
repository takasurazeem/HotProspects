//
//  User.swift
//  HotProspects
//
//  Created by Takasur Azeem on 24/07/2022.
//

import Foundation

extension EnvironmentObjectView {
    
    @MainActor class User: ObservableObject {
        @Published var name = "Takasur Azeem"
    }
    
}
