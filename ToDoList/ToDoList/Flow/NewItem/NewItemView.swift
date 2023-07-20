//
//  NewItemView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI

struct NewItemView: View {

    @StateObject var viewModel = NewItemViewModel()

    @Binding var isNewItemViewPresented: Bool

    var body: some View {

        VStack {
            Text("Add New Item")
                .bold()
                .font(.system(size: 32))
                .padding(.top, 35)

            Form {
                TextField("Title", text: $viewModel.title)
                TextField("Description", text: $viewModel.description)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(.graphical)

                PrimaryButton(title: "Save") {

                    if viewModel.canSave {
                        isNewItemViewPresented = false
                        viewModel.save()
                    } else {
                        viewModel.showAlert = true
                    }

                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Please fill all fields!"))
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView( isNewItemViewPresented: .constant(true))
    }
}
