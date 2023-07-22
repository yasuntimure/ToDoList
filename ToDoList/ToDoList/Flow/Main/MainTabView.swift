//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainTabView: View {

    @AppStorage ("userId") var userId: String = "E3aIHW8gKAcoJWWsK8It31rGsrM2"


    @StateObject var viewModel = MainTabViewModel()

    @State var userLoggedIn: Bool = false

    var body: some View {
        NavigationView {
//            if userLoggedIn {
                AccountView
//            } else {
//                LoginView(userLoggedIn: $userLoggedIn)
//            }
        }
    }
}


// MARK: - User Login Condition

//extension MainTabView {

//    var userLoggedIn: Bool {
//        return false // viewModel.isSigned && !viewModel.currentUserId.isEmpty
//    }
//}



// MARK: - Account TabView

extension MainTabView {

    var AccountView: some View {
        TabView {
            ToDoListView(userId: userId)
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
