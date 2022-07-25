//
//  ResultTypeContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI

struct ResultTypeContentView: View {
    
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    /*
     // old school
     
    func fetchReadings() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        } catch {
            print("Download error.")
        }
    }
     */
    
    func fetchReadings() async {
        let fetchTask = Task { ()-> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let res):
            output = res
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

struct ResultTypeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ResultTypeContentView()
    }
}
