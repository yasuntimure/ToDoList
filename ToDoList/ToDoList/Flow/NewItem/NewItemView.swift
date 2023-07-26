//
//  NewItemView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct NewItemView: View {

    @EnvironmentObject var viewModel: MainViewModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            GradientView()

            ScrollView (.vertical)  {
                Text("Add New Item")
                    .bold()
                    .font(.system(size: 32))
                    .padding(.top, 10)
                    .shadow(radius: 12)

                TextField("Title", text: $viewModel.newItem.title)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .frame(height: 50)

                TextField("Description", text: $viewModel.newItem.description)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .frame(minHeight: 80, maxHeight: 500)


                DatePicker("Date", selection: $viewModel.newItem.date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                    .frame(height: ScreenSize.width)

                PrimaryButton(title: "Save") {
                    if viewModel.canSave {
                        viewModel.save()
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }

                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Please fill all fields!"))
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
            .environmentObject(MainViewModel())
    }
}
