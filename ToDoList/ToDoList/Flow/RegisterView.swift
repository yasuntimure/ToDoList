//
//  RegisterView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct RegisterView: View {

    private enum Fields {
        case email, password, confirmPassword
    }

    @FocusState private var focusedField: Fields?

    @Environment(\.dismiss) var dismiss

    @State var emailValidation: Validate = .none
    @State var passwordValidation: Validate = .none
    @State var confirmPasswordValidation: Validate = .none
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""

    var body: some View {
        ZStack {
            GradientView()
            VStack {
                VStack (alignment: .leading, spacing: 5) {
                    Text("Register")
                        .font(.largeTitle).bold()
                        .foregroundStyle(Color.mTintColor)
                    Text("Create a new Account!")
                        .font(.title2).bold()
                }
                .hSpacing(.leading).padding(.leading)

                VStack (spacing: 10) {
                    if !emailValidation.message.isEmpty {
                        Text(emailValidation.message)
                            .font(.caption2)
                            .foregroundColor(emailValidation.status == .approved ? .green : .red)
                            .hSpacing(.leading).padding(.leading)
                    }

                    TextField("Enter Email", text: $email)
                        .textFieldStyle()
                        .focused($focusedField, equals: .email)
                        .onSubmit(of: .text) {
                            emailValidation = Validations.validate(email: email)
                            if emailValidation.status == .approved {
                                focusedField = (focusedField == .email) ? .password : nil
                            }
                        }
                        .padding(.bottom, 10)

                    if !passwordValidation.message.isEmpty {
                        Text(passwordValidation.message)
                            .font(.caption2)
                            .foregroundColor(emailValidation.status == .approved ? .green : .red)
                            .hSpacing(.leading).padding(.leading)
                    }

                    SecureField("Enter Password", text: $password)
                        .textFieldStyle()
                        .focused($focusedField, equals: .password)
                        .padding(.bottom, 10)
                        .onSubmit {
                            passwordValidation = Validations.validate(password: password)
                        }

                    if !confirmPasswordValidation.message.isEmpty {
                        Text(confirmPasswordValidation.message)
                            .font(.caption2)
                            .foregroundColor(confirmPasswordValidation.status == .approved ? .green : .red)
                            .hSpacing(.leading).padding(.leading)
                    }

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle()
                        .focused($focusedField, equals: .password)
                        .padding(.bottom, 10)
                        .onSubmit {
                            confirmPasswordValidation = Validations.validate(confirmPassword: confirmPassword,
                                                                             password: password)
                        }
                }
                .padding(.top)

                PrimaryButton(title: "Register") {
                    if emailValidation.status == .approved && 
                        passwordValidation.status == .approved &&
                        confirmPasswordValidation.status == .approved {
                        AuthService().register(with: .email(email: email, password: password))
                    }
                }

                DividerLine()

                // Sign Up with Google
                SignInWithButton(signInType: .google) {
                    AuthService().register(with: .google)
                }
            }
            .vSpacing(.top).padding(.top, 50)
        }

    }

    @ViewBuilder
    private func DividerLine() -> some View {
        HStack (spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 1.5)
                .foregroundColor(.secondary)
                .opacity(0.5)
                .padding(.leading, 30)
            Text("with")
                .font(.system(size: 16)).bold()
                .foregroundColor(.secondary)
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 1.5)
                .foregroundColor(.secondary)
                .opacity(0.5)
                .padding(.trailing, 30)
        }
        .padding([.top, .bottom], ScreenSize.width/20)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
