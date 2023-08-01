//
//  LoginView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewModel()

    var body: some View {

        ZStack {
            
            GradientView()
            
            VStack {
                HeaderView()

                TextFieldView(input: $viewModel.email, isSecure: false)
                    .frame(width: ScreenSize.defaultWidth)
                    .padding(.top, ScreenSize.width/8)

                TextFieldView(input: $viewModel.password, isSecure: true)
                    .frame(width: ScreenSize.defaultWidth)

                PrimaryButton(title: "Login") {
                    viewModel.login()
                }
                .padding(.top, ScreenSize.width/12)
                .padding(.bottom, ScreenSize.width/10)
                
                VStack (spacing: 5) {
                    Text("New around here?")
                    Button("Create An Account") {
                        viewModel.isRegisterPresented = true
                    }
                    .bold()
                    .foregroundColor(Color.secondary)
                }
                .padding(.bottom, 100)
                
            }
            .sheet(isPresented: $viewModel.isRegisterPresented) {
                RegisterView()
                    .presentationDetents([.large])
            }
            .userId(viewModel.userId)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
