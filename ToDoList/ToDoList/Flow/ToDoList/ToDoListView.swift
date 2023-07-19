//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct ToDoListView: View {

    @StateObject var viewModel = ToDoListViewModel()

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    var body: some View {
        NavigationView {
            VStack {

            }
            .navigationTitle("To Do List")
            .toolbar {
                PlusButtonView { viewModel.isNewItemViewPresented = true }
            }
            .sheet(isPresented: $viewModel.isNewItemViewPresented) {
                NewItemView(isNewItemViewPresented: $viewModel.isNewItemViewPresented)
            }
        }

    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "2354")
    }
}
