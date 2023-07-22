////
////  NewItemViewModel.swift
////  ToDoList
////
////  Created by Eyüp on 2023-07-10.
////
//
//import FirebaseAuth
//import FirebaseFirestore
//
//class NewItemViewModel: ObservableObject {
//
//    @Published var title: String = ""
//    @Published var description: String = ""
//    @Published var date: Date = Date()
//
//    @Published var showAlert: Bool = false
//
//    var canSave: Bool {
//        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
//        !description.trimmingCharacters(in: .whitespaces).isEmpty
//    }
//
//    init() {}
//
//    func save() {
//
//        guard let uId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        // Create model
//        let newId = UUID().uuidString
//        let newItem = ToDoListItem(id: newId,
//                                   title: title,
//                                   description: description,
//                                   date: date.timeIntervalSince1970,
//                                   isDone: false)
//
//        // Save model
//        let db = Firestore.firestore()
//        db.collection ("users")
//            .document (uId)
//            .collection("todos")
//            .document (newId)
//            .setData(newItem.asDictionary())
//
//    }
//
//}
//
