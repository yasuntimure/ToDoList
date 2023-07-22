//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation
import FirebaseFirestoreSwift

struct ToDoListItem: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var description: String?
    var date: TimeInterval
    var isDone: Bool = false

    mutating func set(_ status: Bool) {
        isDone = status
    }
}
