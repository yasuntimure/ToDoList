//
//  NotesService.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-22.
//

import Firebase
import FirebaseFirestore
import SwiftKeychainWrapper

enum ListServiceAction {
    case getLists
    case postList(_ list: ToDoListModel)
    case putList(_ list: ToDoListModel)
    case deleteList(_ list: ToDoListModel)
}

enum ItemServiceAction {
    case getItems
    case postItem(_ item: ToDoListItemModel)
    case putItem(_ item: ToDoListItemModel)
    case deleteItem(_ item: ToDoListItemModel)
}

struct ListService {

    private static var userId: String {
        return KeychainWrapper.standard.string(forKey: "userIdKey") ?? ""
    }

    static func getLists() async throws -> [ToDoListModel] {
        guard let collection = FirestorePath.users(userId)?.lists().asCollection() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.getArray(of: ToDoListModel(), from: collection).get()
    }

    static func delete(_ list: ToDoListModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.delete(document).get()
    }

    static func post(_ list: ToDoListModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.post(list, to: document).get()
    }

    static func put(_ list: ToDoListModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.put(list, to: document).get()
    }
}

struct ItemService {

    private var userId: String {
        return KeychainWrapper.standard.string(forKey: "userIdKey") ?? ""
    }

    let list: ToDoListModel

    init(list: ToDoListModel) {
        self.list = list
    }

    func getItems() async throws -> [ToDoListItemModel] {
        guard let collection = FirestorePath.users(userId)?.lists(list.id).asCollection() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.getArray(of: ToDoListItemModel(), from: collection).get()
    }

    func delete(_ item: ToDoListItemModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).items(item.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.delete(document).get()
    }

    func post(_ item: ToDoListItemModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).items(item.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.post(list, to: document).get()
    }

    func put(_ item: ToDoListItemModel) async throws {
        guard let document = FirestorePath.users(userId)?.lists(list.id).items(item.id).asDocument() else {
            throw FirebaseError.invalidPath
        }
        return try await FirebaseService.shared.put(item, to: document).get()
    }
}
