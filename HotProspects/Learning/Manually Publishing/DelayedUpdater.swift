//
//  DelayedUpdater.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import Foundation

@MainActor class DelayedUpdater: ObservableObject {
    
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
