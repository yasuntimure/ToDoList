//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation
import FirebaseFirestoreSwift

struct ToDoListItemModel: FirebaseIdentifiable {
    var id: String
    var title: String
    var description: String
    var date: TimeInterval
    var isDone: Bool = false

    init(id: String = UUID().uuidString,
         title: String = "",
         description: String = "",
         date: TimeInterval = Date().timeIntervalSince1970,
         isDone: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.isDone = isDone
    }
}