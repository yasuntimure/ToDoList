//
//  LoginView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct LoginView: View {

    @Environment(\.navigate) var navigate

    private enum Fields {
        case email, password
    }

    @FocusState private var focusedField: Fields?

    @State var emailValidation: Validate = .none
    @State var passwordValidation: Validate = .none
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {

        ZStack {

            GradientView()

            VStack {

                HeaderView()
                    .frame(width: ScreenSize.width - 50)
                    .padding(.top)

                Text("Sign In")
                    .font(.system(size: 32)).bold()
                    .foregroundColor(.secondary)
                    .hSpacing(.leading)
                    .padding([.leading], 30)
                    .padding(.top)

                if !emailValidation.message.isEmpty {
                    Text(emailValidation.message)
                        .font(.caption2)
                        .foregroundColor(emailValidation.status == .approved ? .green : .red)
                        .hSpacing(.leading).padding(.leading)
                }

                TextField("Enter Email", text: $email)
                    .focused($focusedField, equals: .email)
                    .textFieldStyle()
                    .onSubmit(of: .text) {
                        emailValidation = Validations.validate(email: email)
                        if emailValidation.status == .approved {
                            focusedField = (focusedField == .email) ? .password : nil
                        }
                    }
                    .padding(.bottom, 10)

                if !emailValidation.message.isEmpty {
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


                PrimaryButton(title: "Login") {
                    AuthService().login(with: .email(email: email, password: password))
                }

                DividerLine()

                // Sign In with Google
                SignInWithButton(signInType: .google) {
                    AuthService().login(with: .google)
                }
                .padding([.bottom], ScreenSize.width/10)

                CreateAccountView()
                    .padding(.bottom)

            }
            .vSpacing(.center)
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

    @ViewBuilder
    private func CreateAccountView() -> some View {
        VStack (spacing: 5) {
            Text("New around here?")
            Button("Create An Account") {
                navigate(.register)
            }
            .bold()
            .foregroundColor(Color.mTintColor.opacity(0.9))
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
