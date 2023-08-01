//
//  NewListView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-29.
//

import SwiftUI

struct NewListView: View {

    @EnvironmentObject var viewModel: MainViewModel

    @FocusState var titleFocused: Bool

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {

            ScrollView (.vertical)  {
                Text("Add New List")
                    .bold()
                    .font(.system(size: 32))
                    .padding(.top, 35)
                    .shadow(radius: 1, x: 1, y: 1)

                VStack {
                    TextField("Title", text: $viewModel.newList.title)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .frame(height: 70)
                        .focused($titleFocused)

                    TextField("Description", text: $viewModel.newList.description)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 80, maxHeight: 500)
                }
                .padding(.horizontal, 25)

                PrimaryButton(title: "Save") {
                    if viewModel.canSave {
                        viewModel.saveNewList()
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .frame(width: ScreenSize.width)

                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Please fill all fields!"))
                }
            }

        }
        .onAppear {
            titleFocused = true
        }
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView()
            .environmentObject(MainViewModel())
    }
}

