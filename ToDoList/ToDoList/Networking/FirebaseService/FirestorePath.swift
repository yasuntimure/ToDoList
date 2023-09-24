//
//  FirestorePath.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-22.
//

import FirebaseFirestore

struct FirestorePath {

    private var currentReference: Any

    private init(reference: Any) {
        self.currentReference = reference
    }

    func asDocument() -> DocumentReference? {
        return currentReference as? DocumentReference
    }

    func asCollection() -> CollectionReference? {
        return currentReference as? CollectionReference
    }

    enum Collection: String {
        case users
        case notes
        case todos
    }

    static func users(_ id: String) -> FirestorePath? {
        if !id.isEmpty {
            let ref: DocumentReference = FirebaseService.shared.database.collection(Collection.users.rawValue).document(id)
            return FirestorePath(reference: ref)
        }
        return nil
    }

    func items(_ id: String? = nil) -> FirestorePath {
        path(Collection.todos.rawValue, of: id)
    }

    func lists(_ id: String? = nil) -> FirestorePath {
        path(Collection.notes.rawValue, of: id)
    }


    func path(_ collection: String, of id: String? = nil) -> FirestorePath {
        guard let ref = currentReference as? DocumentReference else { fatalError("Invalid chaining") }
        if let id = id {
            let newRef: DocumentReference = ref.collection(collection).document(id)
            return FirestorePath(reference: newRef)
        } else {
            let newRef: CollectionReference = ref.collection(collection)
            return FirestorePath(reference: newRef)
        }
    }
}

