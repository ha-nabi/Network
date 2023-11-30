//
//  ContentView.swift
//  WeatherAPI
//
//  Created by 강치우 on 12/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var network = WeatherAPI.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.weather, id: \.self) { result in
                    HStack {
                        Text(result.main)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            network.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
