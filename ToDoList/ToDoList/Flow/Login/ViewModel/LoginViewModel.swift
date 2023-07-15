//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    
    
    @Published var email: InputField = InputField(placeholder: "Enter Email", text: "", validation: Validation.none)
    @Published var password: InputField = InputField(placeholder: "Enter Password", text: "", validation: Validation.none)
    
    init() {}
    
    func login() {
        
        email.validation = getEmailValidationStatus()
        password.validation = getPasswordValidationStatus()
        
        guard email.validation == .email(.approved) && password.validation == .password(.approved) else { return }
            
        // Try Login
        Auth.auth().signIn(withEmail: email.text, password: password.text) { result, error in
            guard let user = result?.user, error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            print("User: \(user)")
        }
        
    }
    
    func getEmailValidationStatus() -> Validation {
        
        guard !email.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .email(.empty)
        }
        
        guard email.text.contains("@") && email.text.contains(".") else {
            return .email(.invalid)
        }
        
        return .email(.approved)
    }
    
    func getPasswordValidationStatus() -> Validation {
        
        guard !password.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .password(.empty)
        }
        
        guard password.text.count < 64 && password.text.count >= 6 else {
            return .password(.invalid)
        }
        
        return .password(.approved)
    }
        
    
}



enum ValidationStatus: String {
    case approved = "Approved!"
    case empty = "is empty!"
    case invalid = "is invalid!"
    case notMatching = "is not matching!"
}
    

enum Validation: Equatable {
    case name(ValidationStatus)
    case email(ValidationStatus)
    case password(ValidationStatus)
    case confirm_password(ValidationStatus)
    case none
    
    func status() -> ValidationStatus {
        switch self {
        case .name(let validationStatus):
            return validationStatus
        case .email(let validationStatus):
            return validationStatus
        case .password(let validationStatus):
            return validationStatus
        case .confirm_password(let validationStatus):
            return validationStatus
        case .none:
            return .approved
        }
    }
    
    func message() -> String {
        switch self {
        case .name(let validationStatus):
            return "Name" + " " + validationStatus.rawValue
        case .email(let validationStatus):
            return "Email" + " " + validationStatus.rawValue
        case .password(let validationStatus):
            return "Password" + " " + validationStatus.rawValue
        case .confirm_password(let validationStatus):
            return "Confirmation Password" + " " + validationStatus.rawValue
        case .none:
            return " "
        }
    }
}

