//
//  LoginView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()

    @Binding var userLoggedIn: Bool

    var body: some View {
    
        ZStack {
            
            GradientView()
            
            VStack {
                
                HeaderView()
                

                VStack (spacing: 10) {
                    TextFieldView(input: $viewModel.email, isSecure: false)
                    TextFieldView(input: $viewModel.password, isSecure: true)
                }
                .padding(.top, ScreenSize.width/6)
                

                PrimaryButton(title: "Login") {
                    viewModel.login {
                        userLoggedIn = true
                    }
                }

                .padding(.bottom, ScreenSize.width/8)
                
                VStack (spacing: 5) {
                    Text("New around here?")
                    NavigationLink(destination: RegisterView()) {
                        Text("Create An Account")
                    }
                }
                .padding(.bottom, 100)
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userLoggedIn: .constant(false))
    }
}
