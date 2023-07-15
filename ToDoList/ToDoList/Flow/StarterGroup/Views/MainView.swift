//
//  ContentView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

struct MainViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
