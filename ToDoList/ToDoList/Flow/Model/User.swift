//
//  User.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let joinDate: TimeInterval
}
