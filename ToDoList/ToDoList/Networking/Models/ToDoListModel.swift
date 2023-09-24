//
//  ToDoListModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-28.
//

import Foundation
import FirebaseFirestoreSwift

struct ToDoListModel: FirebaseIdentifiable {
    var id: String
    var title: String
    var description: String
    var items: [ToDoListItemModel]
    var date: TimeInterval

    init(id: String = UUID().uuidString,
         title: String = "",
         description: String = "",
         items: [ToDoListItemModel] = [],
         date: TimeInterval = Date().timeIntervalSince1970) {
        self.id = id
        self.title = title
        self.description = description
        self.items = items
        self.date = date
    }
}

extension ToDoListModel {

    static var quickList: ToDoListModel {
        ToDoListModel(title: "Quick Note",
                      description: "Complete your quick to do list!")
    }

    mutating func reorder() {
        if self.items.contains(where: { $0.title.isEmpty }) {
            self.items.sort(by: { ($0.title.isEmpty && !$1.title.isEmpty) || (!$0.isDone && $1.isDone) })
        } else {
            self.items.sort(by: { !$0.isDone && $1.isDone })
        }
    }
}
