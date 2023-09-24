//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

enum ListFields: Hashable {
    case title
    case description
    case itemTitle
}

struct ToDoListView: View {

    @EnvironmentObject var model: MainModel

    @State var list: ToDoListModel

    @FocusState var focusState: ListFields?

    var body: some View {
        VStack (alignment: .leading) {
            TextField("Title...", text: $list.title)
                .font(.title).bold()
                .focused($focusState, equals: .title)
                .onSubmit { focusState = list.description.isEmpty ? .description : nil }
                .padding(.horizontal)

            TextField("Description . . .", text: $list.description, axis: .vertical)
                .font(.title3)
                .foregroundColor(.secondary)
                .focused($focusState, equals: .description)
                .padding(.horizontal)

            ZStack {
                List {
                    ForEach ($list.items) { $item in
                        HStack {
                            VStack (alignment: .leading, spacing: 5) {
                                TextField("Title...", text: $item.title, axis: .vertical)
                                    .font(.headline)
                                    .strikethrough(item.isDone)
                                    .focused($focusState, equals: .itemTitle)

                                if !item.description.isEmpty {
                                    TextField("Description...", text: $item.description)
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                        .strikethrough(item.isDone)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.leading, 5)
                            Spacer()
                            ToggleButton(state: $item.isDone)
                                .frame(width: 35, height: 35)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete{ list.items.remove(atOffsets: $0) }
                    .onMove{ indices, newOffset in
                        list.items.move(fromOffsets: indices, toOffset: newOffset)
                    }
                }
                .toolbar { ToolbarItem(placement: .navigationBarTrailing) { EditButton() } }
                .listStyle(.plain)

                AddNewButton {
                    let emptyItem = ToDoListItemModel()
                    list.items.insert(emptyItem, at: 0)
                    focusState = nil
                }
                .vSpacing(.bottom).padding(.bottom, 30)
            }
        }
        .onAppear {
            if list.title.isEmpty {
                focusState = .title
            } else {
                if list.description.isEmpty {
                    focusState = .description
                }
            }
        }
        .onDisappear {
            if list.title.isEmpty {
                list.title = "Quick List "
            }
            if list.description.isEmpty {
                list.description = "Describe detail of your list!\nCreated \(Date().formatted())"
            }
            model.execute(.putList(list))
            model.execute(.getLists)
        }
        .tint(.secondary)
    }
}


struct ToDoListView_Previews: PreviewProvider {

    static var model: MainModel = {
        var model = MainModel()
        model.userLoggedIn = true
        model.lists = Mock.lists
        return model
    }()

    static var previews: some View {
        ToDoListView(list: Mock.list1)
            .environmentObject(MainModel())
    }
}
