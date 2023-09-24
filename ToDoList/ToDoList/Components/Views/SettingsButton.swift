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
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton {

        }
    }
}
