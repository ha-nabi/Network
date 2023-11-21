//
//  PracticeView.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import SwiftUI

struct PracticeView: View {
    
    @State var users: [String] = []
    
    var body: some View {
        VStack {
            Text(users.first ?? "Error")
            
            Button {
                requestUser()
            } label: {
                Text("Touch Me")
            }
        }
    }
    
    private func requestUser() {
        NetworkManager.shared.requestUser { result in
            
            switch result {
            case .failure(let error):
                switch error {
                case .invalidURL:
                    print("URL이 유효하지 않은 Alert 띄워주기")
                case .badConnection:
                    print("badConnection 띄워주기")
                default:
                    print("알 수 없는 에러 처리")
                }
            case .success(let user):
                users.append(user.name)
            }
        }
    }
}

#Preview {
    PracticeView()
}
