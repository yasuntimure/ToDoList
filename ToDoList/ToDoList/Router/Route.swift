//
//  Route.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-22.
//

import SwiftUI

enum Route: Hashable {
    case home
    case login
    case register
    case toDoList(_ list: ToDoListModel)
    case settings
}

typealias RouteCallback = (Route) -> Void

struct NavigateEnvironmentKey: EnvironmentKey {
    static var defaultValue: RouteCallback = { _ in }
}

extension EnvironmentValues {
    var navigate: RouteCallback {
        get { self [NavigateEnvironmentKey.self] }
        set { self [NavigateEnvironmentKey.self] = newValue }
    }
}

struct ListServiceEnvironmentKey: EnvironmentKey {
    static var defaultValue: ListService = ListService()
}

extension EnvironmentValues {
    var listService: ListService {
        get { self [ListServiceEnvironmentKey.self] }
        set { self [ListServiceEnvironmentKey.self] = newValue }
    }
}
