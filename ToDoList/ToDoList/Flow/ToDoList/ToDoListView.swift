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
                    viewModel.fetchItems(id: userId)
                }
                .refreshable {
                    viewModel.fetchItems(id: userId)
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
        ToDoListView(userId: "E3aIHW8gKAcoJWWsK8It31rGsrM2")
    }
}
