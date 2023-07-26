//
//  ProfileViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {

    @Published var userName: String = "Eyup Yasuntimur"
    @Published var joinDate: String = "22.07.2023"

    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            showAlert = true
            errorMessage = signOutError.description
        }
    }

}
