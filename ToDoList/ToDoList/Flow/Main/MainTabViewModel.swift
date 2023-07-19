//
//  MainViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-16.
//

import Foundation
import FirebaseAuth

class MainTabViewModel: ObservableObject {

    @Published var currentUserId: String = ""

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }

    public var isSigned: Bool {
        Auth.auth().currentUser != nil
    }

}
