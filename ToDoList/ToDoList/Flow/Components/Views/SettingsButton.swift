//
//  SettingsButton.swift
//  ToDoList
//
//  Created by Eyüp on 2023-08-04.
//

import SwiftUI

struct SettingsButton: View {

    @Environment (\.colorScheme) var color: ColorScheme

    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "gear")
                .resizable()
                .foregroundColor(.primary)
                .frame(width: 30, height: 30)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton {

        }
    }
}
