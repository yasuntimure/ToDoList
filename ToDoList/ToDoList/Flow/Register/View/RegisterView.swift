//
//  RegisterView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct RegisterView: View {

    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {

        ZStack {
            GradientView()
            VStack {

                VStack (alignment: .leading, spacing: 5) {
                    Text("Register")
                        .font(.system(size: 45))
                        .bold()
                    Text("Create a new Account!")
                        .font(.system(size: 30))
                        .bold()
                }
                .padding(.top, ScreenSize.width/4)
                .frame(width: ScreenSize.defaultWidth)
                
                VStack (spacing: 10) {

                    TextFieldView(input: $viewModel.inputs.name)
                    TextFieldView(input: $viewModel.inputs.email)
                    TextFieldView(input: $viewModel.inputs.password, isSecure: true)
                    TextFieldView(input: $viewModel.inputs.confirmPassword, isSecure: true)
                    
                }
                .frame(width: ScreenSize.defaultWidth)
                .padding(.top)


                PrimaryButton(title: "Register") {
                    viewModel.register(with: .email) { dismiss() }
                }

                DividerLine()

                // Sign Up with Google
                SignInWithButton(signInType: .google) {
                    viewModel.register(with: .google) { dismiss() }
                }
                .shadow(radius: 2)
                .padding([.bottom], ScreenSize.width/4)

            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }

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
