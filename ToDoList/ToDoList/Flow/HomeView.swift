//
//  HomeView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct HomeView: View {

    @Environment (\.colorScheme) var colorScheme
    @Environment (\.navigate) var navigate
    @EnvironmentObject var model: MainModel

    @State var isEditable: Bool = false

    var body: some View {
        if model.userLoggedIn {
            NavigationView {
                ZStack {
                    List {
                        ForEach (model.lists) { list in
                            NavigationLink(destination: ToDoListView(list: list)) {
                                ToDoRow(list: list)
                            }
                        }
                        .onDelete{ indexSet in
                            indexSet.forEach { index in
                                model.execute(.deleteList(model.lists[index]))
                            }
                            model.lists.remove(atOffsets: indexSet)
                        }
                        .onMove{ indices, newOffset in
                            model.lists.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                    .listStyle(.plain)
                    .task { model.execute(.getLists) }
                    .background(.clear)
                    .refreshable { model.execute(.getLists) }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                        ToolbarItem(placement: .navigationBarTrailing) { SettingsButton {navigate(.settings)} }
                    }

                    AddNewButton {
                        let emptyItem = ToDoListItemModel()
                        let list = ToDoListModel(items: [emptyItem])
                        model.execute(.postList(list))
                        navigate(.toDoList(list))
                    }
                    .vSpacing(.bottom).padding(.bottom, 30)
                }
                .navigationTitle("Notes")
                .onAppear {  model.darkModeSelected = colorScheme == .dark }
                .preferredColorScheme(model.displayMode.colorScheme)
            }
            .tint(.secondary)
        } else {
            LoginView()
                .preferredColorScheme(model.displayMode.colorScheme)
                .onAppear { model.darkModeSelected = colorScheme == .dark }
        }
    }

    @ViewBuilder
    private func ToDoRow(list: ToDoListModel) -> some View {
        HStack {
            Image(systemName: "doc.text")
                .font(.largeTitle)

            VStack (alignment: .leading, spacing: 5) {
                Text(list.title)
                    .font(.headline)

                if !list.description.isEmpty {
                    Text(list.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.leading, 5)
            Spacer()
        }
        .padding(.vertical, 5)
    }
}


// MARK: - Preview

struct HomeView_Previews: PreviewProvider {

    static var model: MainModel = {
        var model = MainModel()
        model.userLoggedIn = true
        model.lists = Mock.lists
        return model
    }()

    static var previews: some View {
        HomeView()
            .environmentObject(model)
    }
}
