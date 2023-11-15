//
//  User.swift
//  NetworkPractice
//
//  Created by 강치우 on 11/15/23.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name, username, email, phone: String
    let website, province, city, district, street, zipcode: String
    let createdAt, updatedAt: String
}
