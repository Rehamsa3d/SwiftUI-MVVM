//
//  UserService.swift
//  await + MVVM
//
//  Created by Reham on 28/12/2025.
//

import Foundation

protocol UserService {
    func fetchUsers() async throws -> [User]
}






//struct MockUserService: UserService {
//    func fetchUsers() async throws -> [User] {
//        try await Task.sleep(for: .seconds(1))
//        return [
//            User(id: 1, name: "Ali"),
//            User(id: 2, name: "Sara"),
//            User(id: 3, name: "Omar")
//        ]
//    }
//}
struct RemoteUserService: UserService {

    func fetchUsers() async throws -> [User] {
        let url = URL(string: "https://dummyjson.com/users")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        // Decode wrapper object
        let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
        return decoded.users
    }

}
