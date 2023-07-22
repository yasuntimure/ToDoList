//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainTabView: View {


    @StateObject var viewModel = MainTabViewModel()

    @State var userLoggedIn: Bool = false {
        didSet {
            userLoggedIn = viewModel.isSigned && !viewModel.currentUserId.isEmpty
        }
    }

    var body: some View {
        NavigationView {
            if userLoggedIn {
                AccountView
            } else {
                LoginView(userLoggedIn: $userLoggedIn)
            }
        }
    }
}

// MARK: - Account TabView

extension MainTabView {

    var AccountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }

}


// MARK: - Preview

struct MainViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
