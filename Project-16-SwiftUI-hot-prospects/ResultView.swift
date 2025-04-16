//
//  ResultView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 15/04/25.
//

import SwiftUI

struct ResultView: View {
    
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadingNewVersion()
            }
    }
    
    func fetchReading() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) reading"
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchReadingNewVersion() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) reading"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ResultView()
}
