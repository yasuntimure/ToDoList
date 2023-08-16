//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

enum DisplayMode: Int {

    case system, dark, light

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .dark: return ColorScheme.dark
        case .light: return ColorScheme.light
        }
    }
}


class MainViewModel: ObservableObject {

    @AppStorage("displayMode") var displayMode: DisplayMode = .system

    @Published var newListViewPresented = false
    @Published var settingsViewPresented = false
    @Published var lists: [ToDoListModel] = []
    @Published var newList: ToDoList = ToDoList()
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var userName: String = "Eyup Yasuntimur"
    @Published var joinDate: String = "22.07.2023"
    @Published var userId: String = ""
    @Published var isLoading: Bool = false
    @Published var darkModeSelected: Bool = false

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let uid = user?.uid, !uid.isEmpty {
                self?.userId = uid
                self?.fetchLists()
            }
        }
    }

    var canSave: Bool {
        !newList.title.trimmingCharacters(in: .whitespaces).isEmpty
    }


    func fetchLists() {
        lists = []

        isLoading = true

        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("notes")
            .getDocuments { (querySnapshot, err) in

                if let err = err {

                    print("Error getting documents: \(err)")

                } else {

                    guard let documents = querySnapshot?.documents else {
                        print("Documents couldnt casted")
                        return
                    }

                    for document in documents {
                        let result = Result {
                            try document.data(as: ToDoListModel.self)
                        }
                        switch result {
                        case .success(let item):
                            self.lists.append(item)
                        case .failure(let error):
                            print("Error decoding item: \(error)")
                        }
                    }

                    if self.lists.isEmpty {
                        self.saveTemplateList()
                    } else {
                        self.isLoading = false
                    }
                }
            }
    }

    func deleteItems(at indexSet: IndexSet) {
        indexSet.forEach { index in
            Firestore.firestore()
                .collection("users")
                .document(self.userId)
                .collection("notes")
                .document(lists[index].id)
                .delete { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
        }
        lists.remove(atOffsets: indexSet)
    }

    func moveItems(from indexSet: IndexSet, to newIndex: Int) {
        lists.move(fromOffsets: indexSet, toOffset: newIndex)
    }


    func saveNewList() {

        let list = newList.getStructModel()

        // Save model
        Firestore.firestore()
            .collection("users")
            .document(self.userId)
            .collection("notes")
            .document (list.id)
            .setData(list.asDictionary())

        newList.reset()

        fetchLists()
    }

    func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            showAlert = true
            errorMessage = signOutError.description
        }

        completion()
    }

    func saveTemplateList() {

        let list = ToDoListModel(id: UUID().uuidString,
                                 title: "Quick Note",
                                 description: "Complete your quick to do list!",
                                 items: [],
                                 date: Date().timeIntervalSince1970)

        guard !userId.isEmpty else {
            self.isLoading = false
            return
        }

        // Save model
        Firestore.firestore()
            .collection("users")
            .document(self.userId)
            .collection("notes")
            .document (list.id)
            .setData(list.asDictionary())

        self.fetchLists()
    }

}
