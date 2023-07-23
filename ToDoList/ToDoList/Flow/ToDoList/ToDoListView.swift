//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct ToDoListView: View {

    @EnvironmentObject var user: UserInfo

    @StateObject var viewModel = ToDoListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach ($viewModel.items) { $todoItem in
                        ToDoItemRow(item: $todoItem.onNewValue {
                            withAnimation {
                                viewModel.updateIsDoneStatus(of: todoItem)
                            }
                        })
                    }
                    .onDelete(perform: viewModel.deleteItems(at:))
                    .onMove(perform: viewModel.moveItems(from:to:))
                }
                .onAppear {
                    viewModel.fetchItems(id: user.currentId)
                }
                .refreshable {
                    viewModel.fetchItems(id: user.currentId)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                }

                .listStyle(.plain)
                .navigationTitle("To Do List")

                .sheet(isPresented: $viewModel.isNewItemViewPresented) {
                    NewItemView()
                        .presentationDetents([.large])
                }

                VStack {
                    Spacer()

                    PlusButton (size: 25) {
                        viewModel.isNewItemViewPresented = true
                    }
                    .padding(.bottom)
                }



            }

        }
        .environmentObject(viewModel)
    }

}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
