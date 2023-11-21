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
        NetworkManager.shared.requestPost { result in
            
            switch result {
            case .success(let post):
                self.posts.append(post.title)
            case .failure(let error):
                switch error {
                    
                case .invalidURL:
                    print("invalidURL")
                case .badConnection:
                    print("badConnection")
                case .invalidResponse:
                    print("invalidResponse")
                case .invalidData:
                    print("invalidData")
                }
            }
        }
    }
    
     func requestUser() {
         NetworkManager.shared.requestUser { result in
             switch result {
             case .success(let user):
                 self.users.append(user.name)
             case .failure(let error):
                 switch error {
                     
                 case .invalidURL:
                     print("URL이 유효하지 않은 Alert 띄워주기")
                 case .badConnection:
                     print("badConnection 띄워주기")
                 default:
                     print("알 수 없는 에러 처리")
                 }
             }
         }
     }
}
