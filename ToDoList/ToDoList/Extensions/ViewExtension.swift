//
//  ViewExtension.swift
//  ToDoList
//
//  Created by Eyüp on 2023-08-17.
//

import Foundation
import SwiftUI

// Custom View Extensions
extension View {

    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }

}

// Login & Register View TextFieldStyle
extension View {
    func textFieldStyle() -> some View {
        self
            .frame(height: ScreenSize.defaultHeight)
            .padding(.horizontal)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.primary, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}
