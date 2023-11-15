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
        NetworkManager.shared.requestUser { user, error in
            
            guard let post = user else {
                print(error)
                return
            }
            
            users.append(user?.name ?? "ErrorName")
        }
    }
}

#Preview {
    PracticeView()
}
