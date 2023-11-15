//
//  ContentViewModel.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published var posts: [String] = ["Ciu", "Ok"]
    @Published var users: [String] = ["user1", "user2"]
   
    // 데이터 호출
     func requestPost() {
        NetworkManager.shared.requestPost { post, error in
            
            guard let post = post else {
                print(error)
                return
            }
            
            self.posts.append(post.title)
        }
    }
    
     func requestUser() {
        
        NetworkManager.shared.requestUser { user, error in
            
            guard let post = user else {
                print(error)
                return
            }
            
            self.users.append(user?.name ?? "ErrorName")
        }
    }
}
