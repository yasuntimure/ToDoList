//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation

struct TodoItem: Codable, Identifiable {
    let id: UUID
    var title: String
    var description: String?
    var isDone: Bool = false
}
