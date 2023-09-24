//
//  AuthService.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-23.
//

import Firebase
import FirebaseFirestore
import GoogleSignIn
import SwiftKeychainWrapper

struct AuthService {

    func login(with type: SignInType) {
        switch type {
        case .google:
            self.signInWithGoogle { email, password in
                self.signIn(withEmail: email, password: password)
            }
        case .apple:
            break // TODO: Sign In with Apple
        case .email(let email, let password):
            signIn(withEmail: email, password: password)
        }
    }

    private func signIn(withEmail: String, password: String) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                return
            }
            let userName = user.displayName ?? "user"
            print("Success: \(userName) logged in")
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

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            guard let user = signInResult?.user else { return }
            guard let email = user.profile?.email, let password = user.userID else { return }
            completion(email, password)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            // TODO: handle error
        }
    }

    func register(with type: SignInType) {
        switch type {
        case .google:
            signInWithGoogle { email, password in
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard let userId = result?.user.uid, error == nil else { return }
                    let newUser = UserModel(id: userId, name: email, email: email, password: password, joinDate: Date().timeIntervalSince1970)
                    newUser.saveToFirestore()
                }
            }
        case .apple:
            break // TODO: Sign Up with Apple
        case .email(let email, let password):
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard let userId = result?.user.uid, error == nil else { return }
                let newUser = UserModel(id: userId, name: email, email: email, password: password, joinDate: Date().timeIntervalSince1970)
                newUser.saveToFirestore()
            }
        }
    }
}
