//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct ToDoItemRow: View {

    @Binding var item: ToDoListItem

    var body: some View {
        HStack {
            ToggleButton(state: $item.isDone)
                .frame(width: 40, height: 40)

            VStack (alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isDone)

                if let description = item.description {
                    Text(description)
                        .font(.body)
                        .strikethrough(item.isDone)
                }
            }
            .padding(.leading, 5)

            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct ToDoItemRow_Previews: PreviewProvider {

    static let todoItemWithoutDescription = ToDoListItem(
        id: UUID().uuidString,
        title: "Buy some bread 🥖",
        date: Date().timeIntervalSince1970
    )

    static let todoItemWithDescription = ToDoListItem(
        id: UUID().uuidString,
        title: "Buy some milk 🥛",
        description: "Get a lactose free one",
        date: Date().timeIntervalSince1970
    )

    static var previews: some View {
        Group {
            Stateful(value: todoItemWithoutDescription) { todoItem in
                ToDoItemRow(item: todoItem)
            }
                .previewDisplayName("Without Description")

            Stateful(value: todoItemWithDescription) { todoItem in
                ToDoItemRow(item: todoItem)
            }
            .previewDisplayName("With Description")
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

