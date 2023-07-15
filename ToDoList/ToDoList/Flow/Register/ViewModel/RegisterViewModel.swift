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
    
    @Published var name: InputField = InputField(placeholder: "Enter Name", text: "", validation: Validation.none)
    @Published var email: InputField = InputField(placeholder: "Enter Email", text: "", validation: Validation.none)
    @Published var password: InputField = InputField(placeholder: "Enter Password", text: "", validation: Validation.none)
    @Published var confirmPassword: InputField = InputField(placeholder: "Confirm Password", text: "", validation: Validation.none)
    
    init() {}
    
    func register() {
        
        name.validation = getNameValidation()
        email.validation = getEmailValidation()
        password.validation = getPasswordValidation()
        confirmPassword.validation = getConfirmValidation()
        
        guard email.validation == .email(.approved) && password.validation == .password(.approved) else { return }
            
        // Try login
        //  Auth.auth().signIn(withEmail: email, password: password)
        print("Try login")
        
    }
    
    func getNameValidation() -> Validation {
        guard !name.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .name(.empty)
        }
        return .name(.approved)
    }
    
    func getEmailValidation() -> Validation {
        
        guard !email.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .email(.empty)
        }
        
        guard email.text.contains("@") && email.text.contains(".") else {
            return .email(.invalid)
        }
        
        return .email(.approved)
    }
    
    func getPasswordValidation() -> Validation {
        
        guard !password.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .password(.empty)
        }
        
        guard password.text.count < 64 && password.text.count >= 6 else {
            return .password(.invalid)
        }
        
        return .password(.approved)
    }
    
    func getConfirmValidation() -> Validation {
        guard !confirmPassword.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .confirm_password(.empty)
        }
        
        guard confirmPassword.text == password.text else {
            return .confirm_password(.invalid)
        }
        
        return .confirm_password(.approved)
    }
        
}

