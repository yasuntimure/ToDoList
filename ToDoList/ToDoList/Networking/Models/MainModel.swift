//
//  Model.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import SwiftKeychainWrapper

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


@MainActor
class MainModel: ObservableObject {

    @AppStorage("displayMode") var displayMode: DisplayMode = .system

    @Published var userLoggedIn: Bool = false

    @Published var lists: [ToDoListModel] = []

    @Published var darkModeSelected: Bool = false

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let userId = user?.uid else { return }
            KeychainWrapper.standard.set(userId, forKey: "userIdKey")
            self?.userLoggedIn = true
            self?.execute(.getLists)
        }
    }

    func execute(_ action: ListServiceAction) {
        Task {
            do {
                switch action {
                case .getLists:
                    self.lists = try await ListService.getLists()
                    if self.lists.isEmpty { self.execute(.postList(ToDoListModel.quickList)) }
                case .postList(let list):
                    try await ListService.post(list)
                case .putList(let list):
                    try await ListService.put(list)
                case .deleteList(let list):
                    try await ListService.delete(list)
                }
            } catch {
                // TODO: ...
            }
        }
    }

    func logout() {
        AuthService().logout()
        KeychainWrapper.standard.removeObject(forKey: "userIdKey")
        userLoggedIn = false
    }

}
