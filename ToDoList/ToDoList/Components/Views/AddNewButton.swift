//
//  AddNewButton.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-23.
//

import SwiftUI

struct AddNewButton: View {

    @Environment (\.colorScheme) var color: ColorScheme

    var size: CGFloat = 20

    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus")
                    .font(.title3).bold()
                    .tint(.systemBackground)
                Text("Add New")
                    .font(.title3).bold()
                    .tint(.systemBackground)
            }
            .padding(.horizontal).padding(.vertical, 10)
            .background(color == .dark ? .white : .black)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.systemBackground, lineWidth: 1.5)
            )

        }
    }
}

#Preview {
    AddNewButton {}
}
