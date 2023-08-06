# ToDoList

ToDoList is a basic note-taking app developed using SwiftUI. The purpose of this project is to experiment with and gain a deep understanding of data flow, property wrappers, modifiers, and other features in SwiftUI. 

The app utilizes Firestore for its database needs. Additionally, the app includes login and registration pages, enabling you to store real-time data. Consequently, you can use this app as a to-do list, as it provides all necessary features right from the initial phase.

## Features

- SwiftUI for UI development
- Firestore for database
- Login and Registration functionality
- Real-time data storage
- Comprehensive to-do list features

### Previews
<p float="left">
  <img src="https://github.com/yasuntimure/ToDoList/assets/58510802/25308413-ef91-4bb2-be5f-57c32d6bf378" width="300" hspace="20"/>
  <img src="https://github.com/yasuntimure/ToDoList/assets/58510802/88e80212-dd81-4ec4-a778-e4d20a283c53" width="300" hspace="20"/>
  <img src="https://github.com/yasuntimure/ToDoList/assets/58510802/2648c626-43f5-462e-9857-c0e922eb4760" width="300" hspace="20"/>
  <img src="https://github.com/yasuntimure/ToDoList/assets/58510802/fe8beca2-0343-4b48-9f9c-7e39c5583ee4" width="300" hspace="20"/>
  <img src="https://github.com/yasuntimure/ToDoList/assets/58510802/d72d4668-d008-4e52-b118-ec3029c451fb" width="300" hspace="20"/>
</p>

## Project Structure

The project is structured as follows:

- `ToDoList.xcodeproj`: Contains the Xcode project files.
- `ToDoList`: Contains the main app files.
  - `App`: Contains the main app file and Google services info.
  - `Extensions`: Contains various Swift extensions used in the project.
  - `Flow`: Contains the main components of the app, including views and view models for Home, Login, Main, NewItem, Profile, Register, and ToDoList.
  - `Model`: Contains the data models used in the project.
  - `Resources`: Contains the app's assets and utility files.

## Usage

To use this project, clone the repository and open `ToDoList.xcodeproj` in Xcode. Make sure you have the necessary credentials to connect to Firestore for the database functionality.
