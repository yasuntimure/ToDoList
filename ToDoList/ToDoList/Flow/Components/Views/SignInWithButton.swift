//
//  SignInWithButton.swift
//  TaskCycle
//
//  Created by Eyüp on 2023-08-14.
//

import SwiftUI

fileprivate struct SignInModel {
    let title: String
    let imageName: String
}

enum SignInType {
    case google, apple, email

    fileprivate var model: SignInModel {
        switch self {
        case .google:
            return SignInModel(title: "Sign In with Google", imageName: "googleLogo")
        case .apple:
            return SignInModel(title: "Sign In with Apple", imageName: "appleLogo")
        case .email:
            return SignInModel(title: "Sign In with Email", imageName: "logo")
        }
    }
}

struct SignInWithButton: View {

    @Environment(\.colorScheme) var colorScheme

    @State var width: CGFloat = ScreenSize.defaultWidth
    @State var height: CGFloat = 50
    @State var signInType: SignInType
    @State var action: () -> Void

    var cornerRadius: CGFloat = 15

    var body: some View {
        Button(action: action) {
            HStack {
                Text(signInType.model.title)
                    .font(.system(size: 20))
                    .foregroundColor(colorScheme == .light ? Color.secondary : Color.backgroundColor)
                    .hSpacing(.leading)
                    .padding(.leading, 20)
                Image(signInType.model.imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.leading, 5)
                    .padding(.trailing, 20)
            }
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.primary, lineWidth: 2)
            )
        }
    }
}

struct SignInWithButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithButton(signInType: .google) {
            // Action
        }
    }
}
