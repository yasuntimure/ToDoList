//
//  NewItemViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import Foundation

class NewItemViewModel: ObservableObject {

    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()

    @Published var showAlert: Bool = false

    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespaces).isEmpty
    }

    init() {}

    func save() {

    }

}

