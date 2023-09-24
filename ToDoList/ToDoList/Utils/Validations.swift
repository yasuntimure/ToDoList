//
//  Validations.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//


struct Validations {

    static func validate(email: String) -> Validate {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Validate.email(.empty)
        }

        guard email.contains("@") && email.contains(".") else {
            return Validate.email(.invalid)
        }

        return Validate.email(.approved)
    }
    
    static func validate(password: String) -> Validate {
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Validate.password(.empty)
        }

        guard password.count < 64 && password.count >= 6 else {
            return Validate.password(.invalid)
        }

        return Validate.password(.approved)
    }

    static func validate(confirmPassword: String, password: String) -> Validate {
        guard !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Validate.confirm_password(.empty)
        }

        guard confirmPassword == password else {
            return Validate.confirm_password(.invalid)
        }

        return Validate.confirm_password(.approved)
    }
}

enum ValidationStatus: String {
    case approved = "Approved!"
    case empty = "is empty!"
    case invalid = "is invalid!"
    case notMatching = "is not matching!"
}

enum Validate: Equatable {
    case name(ValidationStatus)
    case email(ValidationStatus)
    case password(ValidationStatus)
    case confirm_password(ValidationStatus)
    case none

    var status: ValidationStatus {
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
            return .empty
        }
    }

    var message: String {
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
            return ""
        }
    }
}

