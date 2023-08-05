//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainView: View {

    @Environment (\.colorScheme) var colorScheme

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        NavigationView {
            if !viewModel.userId.isEmpty {
                HomeView()
            } else {
                LoginView()
            }
        }
        .environmentObject(viewModel)
        .onUserIdChange { userId in
            self.viewModel.userId = userId
        }
        .preferredColorScheme(viewModel.displayMode.colorScheme)
        .onAppear {
            viewModel.darkModeSelected = colorScheme == .dark
        }
    }
}

// MARK: - Preview

struct MainViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
