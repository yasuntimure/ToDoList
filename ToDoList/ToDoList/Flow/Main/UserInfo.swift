//
//  MainViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-16.
//

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {

    @Published var currentId: String = ""
    @Published var loggedIn: Bool = false
    
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let uid = user?.uid, !uid.isEmpty {
                self?.currentId = uid
                self?.loggedIn = true
            }
        }
    }

}
