//
//  RegisterView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack {
            
            GradientView()
            
            VStack {
                
                HeaderView(
                    title: "Register",
                    subTitle: "Creat an Acccount"
                )
                
                VStack (spacing: 10) {
                    
                    TextFieldView(input: $viewModel.nameField, isSecure: false)
                    
                    TextFieldView(input: $viewModel.emailField, isSecure: false)
                    
                    TextFieldView(input: $viewModel.passwordField, isSecure: true)
                    
                    TextFieldView(input: $viewModel.confirmPasswordField, isSecure: true)
                    
                }
                .padding(.top, ScreenSize.width/10)
                
                PrimaryButton(title: "Register") {
                    viewModel.register()
                }
                .padding(.top, ScreenSize.width/15)
                .padding(.bottom, ScreenSize.width/2)
                
                Spacer()
                
                
//                VStack (spacing: 5) {
//                    Text("Already have an account?")
//                    NavigationLink(destination: LoginView()) {
//                        Text("Sign in with your account")
//                    }
//                }
//                .padding(.bottom, 100)
                
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
