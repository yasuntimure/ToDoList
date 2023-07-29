//
//  HeaderView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct HeaderView: View {

    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    @State var title: String = "To Do List"
    @State var subTitle: String = "Lets get started!"
    
    var body: some View {
            Image("logo")
                .resizable()
                .frame(width: ScreenSize.width/1.2, height: ScreenSize.width/1.2)
                .cornerRadius(ScreenSize.width)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fill)
                .padding(.top, ScreenSize.width/3.5)
                .shadow(
                    color: colorScheme == .light ? .black : .white,
                    radius: 15
                )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
