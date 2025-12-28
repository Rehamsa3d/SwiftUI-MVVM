//
//  ContentView.swift
//  await + MVVM
//
//  Created by Reham on 28/12/2025.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
        }
        .task {
            viewModel.loadUsers()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(error)
                    .foregroundColor(.red)
                Button("Retry") {
                    viewModel.loadUsers()
                }
            }
        } else {
            List(viewModel.users) { user in
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: user.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("\(user.firstName) \(user.lastName)")
                            .font(.headline)
                        Text("Age: \(user.age)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}

