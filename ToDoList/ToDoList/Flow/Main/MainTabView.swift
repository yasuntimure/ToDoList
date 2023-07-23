//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainTabView: View {

    @StateObject var user: UserInfo = UserInfo()

    var body: some View {
        NavigationView {
            if user.loggedIn {
                AccountView
            } else {
                LoginView()
            }
        }
        .environmentObject(user)
    }
}

// MARK: - Account TabView

extension MainTabView {

    var AccountView: some View {
        TabView {
            ToDoListView()
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
