//
//  ToDoListRow.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-29.
//

import SwiftUI

struct ToDoListRow: View {

    @Binding var list: ToDoListModel

    var body: some View {
        HStack {
            Image(systemName: "doc.text")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            VStack (alignment: .leading, spacing: 5) {
                Text(list.title)
                    .font(.headline)


                if !list.description.isEmpty {
                    Text(list.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }

            }
            .padding(.leading, 5)

            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct ToDoListRow_Previews: PreviewProvider {

    static let todoItemWithDescription = ToDoListModel(
        id: UUID().uuidString,
        title: "Buy some milk 🥛",
        description: "Get a lactose free one",
        items: [],
        date: Date().timeIntervalSince1970
    )

    static var previews: some View {
        Group {

            Stateful(value: todoItemWithDescription) { todoItem in
                ToDoListRow(list: todoItem)
            }
            .previewDisplayName("With Description")
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
