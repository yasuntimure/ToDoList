//
//  UserModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseFirestore

struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let joinDate: TimeInterval
}

extension UserModel {
    func saveToFirestore() {
        Firestore.firestore().collection("users")
            .document(self.id)
            .setData(self.asDictionary())
    }
}
