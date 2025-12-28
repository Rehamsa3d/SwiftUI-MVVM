//
//  UsersViewModel.swift
//  await + MVVM
//
//  Created by Reham on 28/12/2025.
//

import Foundation
internal import Combine
@MainActor
class UsersViewModel: ObservableObject {

    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage:String? = nil
        
    private let service: UserService

    init(service: UserService = RemoteUserService()) {
        self.service = service
    }

    func loadUsers() {
        Task{
            isLoading = true
            errorMessage = nil
            //state = .loading
            do {
                let fetchedUsers = try await service.fetchUsers()
                users = fetchedUsers
            } catch {
                errorMessage = "Failed to load users"
            }
            isLoading = false
        }
    }

}
