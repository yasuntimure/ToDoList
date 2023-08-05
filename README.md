# ToDoList

ToDoList is a Swift-based application that allows users to manage their tasks in a simple and efficient way.

## Structure

The application is structured into several main components:

- `ToDoList.xcodeproj`: Contains the Xcode project files.
- `ToDoList`: Contains the main application code, organized into several subdirectories:
  - `App`: Contains the main application file `ToDoListApp.swift` and `GoogleService-Info.plist`.
  - `Extensions`: Contains various Swift extensions to enhance the functionality of the application.
  - `Flow`: Contains the main flow of the application, with each subdirectory representing a different screen or feature of the app.
    - `Components`: Contains reusable views.
    - `Home`: Contains the home view and its related files.
    - `Login`: Contains the login view and its related files.
    - `Main`: Contains the main view and its related files.
    - `NewItem`: Contains the views for adding new items.
    - `Profile`: Contains the profile and settings views.
    - `Register`: Contains the register view and its related files.
    - `ToDoList`: Contains the ToDoList view and its related files.
  - `Model`: Contains the data models used in the application.
  - `Preview Content`: Contains assets for previewing the application.
  - `Resources`: Contains various resources used in the application, such as images and color sets.
  - `Utils`: Contains utility files.

## Setup

To run the application, you need to have Xcode installed on your machine. Open the `ToDoList.xcodeproj` file in Xcode, then build and run the application.

## Contributing

Contributions are welcome! Please read the contributing guidelines before making any changes.

## License

This project is licensed under the terms of the MIT license.
