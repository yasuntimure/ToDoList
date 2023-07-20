//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct ToDoItemRow: View {

    @Binding var item: TodoItem

    var body: some View {
        HStack {
            ToggleButton(state: $item.isDone)
                .frame(width: 70)

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

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ToDoItemRow_Previews: PreviewProvider {

    static let todoItemWithoutDescription = TodoItem(
        id: UUID(),
        title: "Buy some bread 🥖"
    )

    static let todoItemWithDescription = TodoItem(
        id: UUID(),
        title: "Buy some milk 🥛",
        description: "Get a lactose free one"
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

