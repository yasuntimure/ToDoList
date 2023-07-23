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
                
                HeaderView(
                    title: "Register",
                    subTitle: "Creat an Acccount"
                )
                
                VStack (spacing: 10) {

                    TextFieldView(input: $viewModel.inputs.name)
                    TextFieldView(input: $viewModel.inputs.email)
                    TextFieldView(input: $viewModel.inputs.password, isSecure: true)
                    TextFieldView(input: $viewModel.inputs.confirmPassword, isSecure: true)
                    
                }
                .padding(.top, ScreenSize.width/10)
                
                PrimaryButton(title: "Register") {
                    viewModel.register { dismiss() }
                }
                .padding(.top, ScreenSize.width/15)
                .padding(.bottom, ScreenSize.width/2)
                
                Spacer()

            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
