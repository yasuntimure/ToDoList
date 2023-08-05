//
//  ProfileView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {

    @EnvironmentObject var viewModel: MainViewModel

    @State var darkMode: Bool

    var body: some View {

        ZStack {
            Color.secondary
                .ignoresSafeArea()
                .opacity(0.2)

            VStack (alignment: .leading, spacing: 20) {

                Text(viewModel.userName)
                    .styleSettingRow()

                HStack {
                    Text("Joined:")
                        .bold()
                    Text(viewModel.joinDate)
                }
                .styleSettingRow()

                Toggle("Select Apearance", isOn: $darkMode)
                    .styleSettingRow()
                    .onChange(of: darkMode) { isDarkMode in
                        viewModel.displayMode = isDarkMode ? .dark : .light
                    }

                SecondaryButton(title: "Logout") {
                    viewModel.logout {
                        viewModel.userId = ""
                    }
                }
                .padding(.top)

                Spacer()
            }
            .padding([.top, .horizontal], 30)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }
            .navigationTitle("Settings")
        }
        .environmentObject(viewModel)

    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkMode: true)
            .environmentObject(MainViewModel())
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


