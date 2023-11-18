//
//  FunctionTest.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import SwiftUI

struct FunctionTest: View {
    
    var sayHi: (String) -> () = { name in
        print("Hi \(name)")
    }
    
    var body: some View {
        VStack {
            Text("")
            Button {
                // sayHi("Ciu2")
                requestArticle { article, error in
                    if error == "error" {
                        print("error")
                    }
                    
                    // data.append(article)
                }
            } label: {
                Text("Touch")
            }
        }
    }
    
    func requestArticle(completed: @escaping (Post?, String?) -> ()) {
        sayHello(with: "url") { data, response, error in
            if data == "data" {
                // decoder -> Data -> Article
                
                completed(nil, "error")
            }
            
            if response != "response" {
                completed(nil, "errorResponse")
            }
            
            if error == "error" {
                completed(nil, "error")
            }
        }
    }
    
    func sayHello(with name: String, action: (String, String, String) -> ()) {
        print("\(name) Hello")
        action("받아온 데이터", "받아온 결과", "받아온 에러")
    }
}

#Preview {
    FunctionTest()
}
