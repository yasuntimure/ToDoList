//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ToDoListViewModel: ObservableObject {

    @Published var isNewItemViewPresented = false

    @Published var items: [ToDoListItem] = []

    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: Date = Date()
    @Published var showAlert: Bool = false

    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var userId: String = ""

    func fetchItems(id: String) {
        items = []
        userId = id
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("todos").getDocuments { (querySnapshot, err) in
            if let err = err {

                print("Error getting documents: \(err)")

            } else {

                guard let documents = querySnapshot?.documents else {
                    print("Documents couldnt casted")
                    return
                }

                for document in documents {
                    let result = Result {
                        try document.data(as: ToDoListItem.self)
                    }
                    switch result {
                    case .success(let item):
                        self.items.append(item)
                    case .failure(let error):
                        print("Error decoding item: \(error)")
                    }
                }
                self.reorder()
            }
        }
    }

    func reorder() {
        items.sort(by: { !$0.isDone && $1.isDone })
    }

    func deleteItems(at indexSet: IndexSet) {
        let db = Firestore.firestore()
        indexSet.forEach { index in
            db.collection("users").document(self.userId).collection("todos").document(items[index].id).delete { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        items.remove(atOffsets: indexSet)
    }

    func moveItems(from indexSet: IndexSet, to newIndex: Int) {
        items.move(fromOffsets: indexSet, toOffset: newIndex)
    }

    func updateIsDoneStatus(of item: ToDoListItem) {

        let newStatus = item.isDone

        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .updateData(["isDone": newStatus]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }

        // update local array
        if let index = self.items.firstIndex(where: {$0.id == item.id}) {
            self.items[index].set(newStatus)
        }

        self.reorder()
    }


    func save() {

        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        // Create model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(id: newId,
                                   title: title,
                                   description: description,
                                   date: date.timeIntervalSince1970,
                                   isDone: false)

        // Save model
        let db = Firestore.firestore()
        db.collection ("users")
            .document (uId)
            .collection("todos")
            .document (newId)
            .setData(newItem.asDictionary())

        title = ""
        description = ""
        date = Date()
        showAlert = false

    }


}
