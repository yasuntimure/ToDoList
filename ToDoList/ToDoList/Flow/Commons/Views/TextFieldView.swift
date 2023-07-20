//
//  TextFieldView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-15.
//

import SwiftUI

struct InputField {
    var placeholder: String
    var text: String
    var validation: Validation
}

struct TextFieldView: View {
    
    @Binding var input: InputField
    
    var isSecure: Bool
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            Text(input.validation.message())
                .font(.system(size: 14))
                .foregroundColor(input.validation.status() == .approved ? .green : .red)
                .bold()
            
            if isSecure {
                SecureField(input.placeholder, text: $input.text)
                    .padding(12)
                    .border(Color.blue, width: 1)
            
            } else {
                TextField(input.placeholder, text: $input.text)
                    .padding(12)
                    .border(Color.blue, width: 1)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
        }
            .padding(.horizontal)
    }

}

struct TextFieldView_Previews: PreviewProvider {


    static var email: InputField = InputField(placeholder: "Enter Email",
                                              text: "yasuntimure@gmail.com",
                                              validation: .email(.approved))

    static var previews: some View {
        Stateful(value: email) { email in
            TextFieldView(input: email, isSecure: false)
                .previewLayout(.fixed(width: ScreenSize.width, height: ScreenSize.height/8))
        }
    }
}
