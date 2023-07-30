//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainView: View {

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        NavigationView {
            if !viewModel.userId.isEmpty {
                AccountView
            } else {
                LoginView(userId: $viewModel.userId)
            }
        }
        .environmentObject(viewModel)


    }
}

// MARK: - Account TabView

extension MainView {

    var AccountView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                        .foregroundColor(.primary)
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                        .foregroundColor(.primary)
                }
        }
    }

}


// MARK: - Preview

struct MainViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
