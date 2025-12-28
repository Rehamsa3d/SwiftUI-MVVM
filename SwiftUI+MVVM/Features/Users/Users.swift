//
//  Users.swift
//  await + MVVM
//
//  Created by Reham on 28/12/2025.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let image: String
    let address: String
}

struct UsersResponse: Decodable {
    let users: [User]
}
