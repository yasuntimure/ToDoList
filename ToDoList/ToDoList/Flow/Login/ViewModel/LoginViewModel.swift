//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation
import Firebase
import SwiftUI
import Combine
import GoogleSignIn


class LoginViewModel: ObservableObject {

    private var subscription = Set<AnyCancellable>()

    @Published var email: InputField = InputField(placeholder: "Enter Email", text: "", validation: Validation.none)
    @Published var password: InputField = InputField(placeholder: "Enter Password", text: "", validation: Validation.none)
    @Published var isRegisterPresented = false
    @Published var userId: String = ""

    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""

    init() {
        $email
            .dropFirst(4)
            .sink { email in
                if email.text.count > 3 {
                    self.validateEmail()
                }
        }.store(in: &subscription)

        $password
            .dropFirst(4)
            .sink { password in
                if password.text.count > 5 {
                    self.validatePassword()
                }
        }.store(in: &subscription)
    }

    private func showAlert(message: String) {
        errorMessage = message
        showAlert = true
    }
    
    func login(with type: SignInType) {
        switch type {
        case .google:
            self.signInWithGoogle { [weak self] email, password in

                print("Email: ", email)
                print("Password: ", password)

                self?.signIn(withEmail: email, password: password)
            }
        case .apple:
            break // TODO: Sign In with Apple
        case .email:
            validateEmail()
            validatePassword()
            guard email.validation == .email(.approved) && password.validation == .password(.approved) else {
                showAlert(message: "Email or Password not approved!")
                return
            }
            signIn(withEmail: email.text, password: password.text)
        }
    }

    private func signIn(withEmail: String, password: String) {
        // Try Login
        Auth.auth().signIn(withEmail: withEmail, password: password) { [weak self] result, error in

            guard let user = result?.user, error == nil else {
                self?.showAlert(message: error?.localizedDescription ?? "Could not create a new account!")
                return
            }

            self?.userId = user.uid
            let email = String(describing: user.email)
            print("Success: \(email) logged in")
        }
    }

    func checkPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }

            guard let userId = user?.userID else { return }
            self.userId = userId
        }
    }

    private func signInWithGoogle(completion: @escaping (String, String) -> Void) {

        // Create Google Sign In configuration object.
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Prepare presenting viewController
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        guard let rootViewController = window?.rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
            if let error = error {
                self?.showAlert(message: "\(error.localizedDescription)")
            }

            guard let user = signInResult?.user else { return }

            guard let email = user.profile?.email, let password = user.userID else {
                self?.showAlert(message: "An error occured while fetching data from google!")
                return
            }

            completion(email, password)
        }
    }

    func signOut(){
        GIDSignIn.sharedInstance.signOut()
    }
    
}


// MARK: - Validation

extension LoginViewModel {

    func validateFields() {

    }
    
    private func validateEmail() {

        guard !email.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            email.validation = .email(.empty)
            return
        }

        guard email.text.contains("@") && email.text.contains(".") else {
            email.validation = .email(.invalid)
            return
        }

        email.validation = .email(.approved)
    }
    
    private func validatePassword() {

        guard !password.text.trimmingCharacters(in: .whitespaces).isEmpty else {
            password.validation = .password(.empty)
            return
        }

        guard password.text.count < 64 && password.text.count >= 6 else {
            password.validation = .password(.invalid)
            return
        }

        password.validation = .password(.approved)
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

