//
//  SPMContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI
import SamplePackage

struct SPMContentView: View {
    
    @State private var possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
            .onTapGesture {
                self.possibleNumbers.shuffle()
            }
    }
}

struct SPMContentView_Previews: PreviewProvider {
    static var previews: some View {
        SPMContentView()
    }
}
