//
//  HomeView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-28.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var viewModel: MainViewModel
    @State var toDoListPresented: Bool = false

    var body: some View {
        NavigationView {
            ZStack {

                if viewModel.isLoading {
                    LoadingView()
                        .frame(width: 50, height: 50, alignment: .center)
                }

                List {
                    ForEach ($viewModel.lists) { $list in
                        NavigationLink {
                            ToDoListView(
                                viewModel: ToDoListViewModel(userId: viewModel.userId,
                                                             list: list)
                            )
                        } label: {
                            ToDoListRow(list: $list)
                        }
                    }
                    .onDelete(perform: viewModel.deleteItems(at:))
                    .onMove(perform: viewModel.moveItems(from:to:))
                }
                .background(.clear)
                .onAppear { viewModel.fetchLists() }
                .refreshable { viewModel.fetchLists() }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                    ToolbarItem(placement: .navigationBarTrailing) { settingsViewNavigation }
                }
                .listStyle(.plain)
                .navigationTitle("Notes")
                .sheet(isPresented: $viewModel.newListViewPresented) {
                    NewListView()
                        .presentationDetents([.fraction(0.45)])
                        .environmentObject(viewModel)
                }

                plusButton

            }
        }
        .environmentObject(viewModel)

    }

}

// MARK: - Settings View Navigation

extension HomeView {

    var settingsViewNavigation: some View {
        NavigationLink {
            SettingsView()
        } label: {
            Image(systemName: "gear")
                .resizable()
                .foregroundColor(.primary)
                .frame(width: 25, height: 25)
        }
    }
}

// MARK: - Plus Button

extension HomeView {

    var plusButton: some View {
        VStack (alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                PlusButton(size: 25) {
                    viewModel.newListViewPresented = true
                }
                .padding([.trailing, .bottom], 30)
            }
            .padding(.bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MainViewModel())
    }
}
