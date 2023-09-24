//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()

        return true
    }

    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any ]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

}

@main
struct ToDoListApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @Environment(\.colorScheme) var colorScheme

    @State private var routes: [Route] = []

    @StateObject var model = MainModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routes) {
                HomeView()
                    .accentColor(.gray)
                    .navigationDestination(for: Route.self) { route in
                        navigate(to: route)
                    }
            }
            .environment (\.navigate) { route in
                routes.append (route)
            }
            .environmentObject(model)
        }

    }

    @ViewBuilder
    private func navigate(to route: Route) -> some View {
        switch route {
        case .home:
            HomeView()
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .toDoList(let list):
            ToDoListView(list: list)
        case .settings:
            SettingsView(darkMode: colorScheme == .dark)
        }
    }
}
