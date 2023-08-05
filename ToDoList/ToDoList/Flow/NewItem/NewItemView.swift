//
//  NewItemView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct NewItemView: View {

    @EnvironmentObject var viewModel: ToDoListViewModel

    @Environment(\.dismiss) var dismiss

    @FocusState var titleFocused: Bool

    var body: some View {
        ZStack {
            ScrollView (.vertical)  {
                Text("Add New Item")
                    .font(.system(size: 32)).bold()
                    .padding(.top, 35)
                    .shadow(radius: 1, x: 1, y: 1)

                VStack (spacing: 10) {
                    TextField("Title", text: $viewModel.newItem.title)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .frame(height: 60)
                        .focused($titleFocused)

                    TextField("Description", text: $viewModel.newItem.description)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 80, maxHeight: 500)

                    DatePicker("Date", selection: $viewModel.newItem.date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(.top)
                }
                .padding(.horizontal, 25)

                PrimaryButton(title: "Save") {
                    if viewModel.canSave {
                        viewModel.save()
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .frame(width: ScreenSize.width)
                .padding(.top)

                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Please fill all fields!"))
                }
            }
            .padding(.horizontal, 25)
        }
        .onAppear {
            titleFocused = true
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
            .environmentObject(MainViewModel())
    }
}
