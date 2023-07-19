//
//  RegisterViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation
import Firebase
import Combine

class RegisterViewModel: ObservableObject {
    
    @Published var nameField: InputField = InputField(placeholder: "Enter Name", text: "", validation: Validation.none)
    @Published var emailField: InputField = InputField(placeholder: "Enter Email", text: "", validation: Validation.none)
    @Published var passwordField: InputField = InputField(placeholder: "Enter Password", text: "", validation: Validation.none)
    @Published var confirmPasswordField: InputField = InputField(placeholder: "Confirm Password", text: "", validation: Validation.none)
    
    init() {}
    
    func register() {
        nameField.validation = getNameValidation()
        emailField.validation = getEmailValidation()
        passwordField.validation = getPasswordValidation()
        confirmPasswordField.validation = getConfirmValidation()
        
        guard nameField.validation == .name(.approved) &&
                emailField.validation == .email(.approved) &&
                passwordField.validation == .password(.approved) &&
                confirmPasswordField.validation == .confirm_password(.approved) else { return }
        
        // Try Register
        Auth.auth().createUser(withEmail: emailField.text, password: passwordField.text) { [weak self] result, error in
            guard let userId = result?.user.uid, error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            self?.insertUserId(userId)
        }
    }

    func insertUserId(_ userId: String) {
        let newUser = User (
            id: userId,
            name: nameField.text,
            email: emailField.text,
            password: passwordField.text,
            joinDate: Date().timeIntervalSince1970
        )

        let database = Firestore.firestore()

        database.collection("users")
            .document(userId)
            .setData(newUser.asDictionary())
    }
}


// MARK: - Validation

extension RegisterViewModel {

    func getNameValidation() -> Validation {
        guard !nameField.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .name(.empty)
        }
        return .name(.approved)
    }

    func getEmailValidation() -> Validation {

        guard !emailField.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .email(.empty)
        }

        guard emailField.text.contains("@") && emailField.text.contains(".") else {
            return .email(.invalid)
        }

        return .email(.approved)
    }

    func getPasswordValidation() -> Validation {

        guard !passwordField.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .password(.empty)
        }

        guard passwordField.text.count < 64 && passwordField.text.count >= 6 else {
            return .password(.invalid)
        }

        return .password(.approved)
    }

    func getConfirmValidation() -> Validation {
        guard !confirmPasswordField.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .confirm_password(.empty)
        }

        guard confirmPasswordField.text == passwordField.text else {
            return .confirm_password(.invalid)
        }

        return .confirm_password(.approved)
    }
}

