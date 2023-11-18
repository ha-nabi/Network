//
//  ContentView.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import SwiftUI

// 1. 서버에 데이터를 요청한다
// 2. 데이터를 받아온다 (JSON)
// 3. 데이터를 파싱한다
// 4. 파싱한 데이터로 화면을 그린다
// http://koreanjson.com/posts/1
// http://koreanjson.com/users

struct ContentView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.posts, id: \.self) { item in
                    Text(item)
                }
                ForEach(viewModel.users, id: \.self) { item in
                    Text(item)
                }
            }
            
            Button {
                viewModel.requestPost()                  // 버튼을 누를 때 마다 데이터에 넣어줌
            } label: {
                Text("Request Post")
            }
            
            Button {
                viewModel.requestUser()                  // 버튼을 누를 때 마다 데이터에 넣어줌
            } label: {
                Text("Request User")
            }
        }
    }
}
#Preview {
    ContentView()
}
