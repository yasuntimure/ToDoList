//
//  ButtonView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct PrimaryButton: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var title: String
    @State var height: CGFloat = 50
    @State var action: () -> Void

    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(colorScheme == .light ? .black : .white)
                .font(.system(size: 20))
                .bold()
                .frame(height: height)
                .hSpacing(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.primary, lineWidth: 2)
                )
                .padding(.horizontal)
        }
    }

}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue

            PrimaryButton(title: "Login") {
                // action
            }
        }
    }
}
