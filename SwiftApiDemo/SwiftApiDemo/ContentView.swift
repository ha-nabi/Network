//
//  ContentView.swift
//  SwiftApiDemo
//
//  Created by 강치우 on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var network = NewsAPI.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.posts, id: \.self) { result in
                    HStack {
                        AsyncImage(url: URL(string: result.urlToImage ?? "")) { image in
                            image.image?.resizable()
                        }
                        .frame(width: 120, height: 80)
                        
                        Text(result.title)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .onAppear() {
            network.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
