//
//  LoginView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var user: UserInfo

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
                    viewModel.login { user.loggedIn = true }
                }
                .padding(.bottom, ScreenSize.width/8)
                
                VStack (spacing: 5) {
                    Text("New around here?")
                    Button("Create An Account") {
                        viewModel.isRegisterPresented = true
                    }
                }
                .padding(.bottom, 100)
                
            }
            .sheet(isPresented: $viewModel.isRegisterPresented) {
                RegisterView()
                    .presentationDetents([.large])
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
