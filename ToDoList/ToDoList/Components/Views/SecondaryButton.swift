//
//  SecondaryButton.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-23.
//

import SwiftUI

struct SecondaryButton: View {

    @Environment (\.colorScheme) var color

    @State var title: String
    @State var size: CGSize = CGSize(width: ScreenSize.defaultWidth,
                                     height: ScreenSize.defaultHeight)
    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: size.width, height: size.height)
                .font(.system(size: 16)).bold()
                .foregroundColor(color == .light ? .white : .black)
                .background(color == .light ? .black : .white)
                .cornerRadius(size.height)
        }
    }

}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Secondary") { }
    }
}
