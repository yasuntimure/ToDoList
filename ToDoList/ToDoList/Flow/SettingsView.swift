//
//  ProfileView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var model: MainModel

    @State var darkMode: Bool

    var body: some View {
        ZStack {
            Color.secondary
                .ignoresSafeArea()
                .opacity(0.2)

            VStack (alignment: .leading, spacing: 20) {

                Text(" ---- ")
                    .styleSettingRow()

                HStack {
                    Text("Joined:")
                        .bold()
                    Text(" ")
                }
                .styleSettingRow()

                Toggle("Select Apearance", isOn: $darkMode)
                    .styleSettingRow()
                    .onChange(of: darkMode) { isDarkMode in
                        model.displayMode = isDarkMode ? .dark : .light
                    }

                SecondaryButton(title: "Logout") {
                    model.logout()
                    dismiss()
                }
                .padding(.top)

                Spacer()
            }
            .padding([.top, .horizontal], 30)
            .navigationTitle("Settings")
        }
        .preferredColorScheme(model.displayMode.colorScheme)
        .environmentObject(model)
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkMode: true)
            .environmentObject(MainModel())
    }
}

extension View {
    func styleSettingRow() -> some View {
        self.modifier(SettingsRowStyleModifier())
    }
}

struct SettingsRowStyleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 18)).bold()
            .padding(.horizontal)
            .frame(width: ScreenSize.defaultWidth,
                   height: ScreenSize.defaultHeight,
                   alignment: .leading)
            .background(.secondary.opacity(0.3))
            .cornerRadius(ScreenSize.defaultHeight/3)

    }
}


