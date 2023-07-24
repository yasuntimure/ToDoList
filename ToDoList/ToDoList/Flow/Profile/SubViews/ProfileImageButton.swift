//
//  ProfileImageButton.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-23.
//

import SwiftUI

struct ProfileImageButton: View {

//    @Binding var image: Image // TODO: User image will be added
    
    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: ScreenSize.width/3, height: ScreenSize.width/3)
        }

    }
}

struct ProfileImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageButton {
            //
        }
    }
}
