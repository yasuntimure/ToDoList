//
//  HeaderView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct HeaderView: View {
    
    @State var title: String = "To Do List"
    @State var subTitle: String = "Lets get started!"
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 50))
                .bold()
            Text(subTitle)
                .font(.system(size: 25))
                .bold()
        }
            .frame(width: ScreenSize.width - 60, alignment: .leading)
            .padding(.top, ScreenSize.width/3.5)
            .foregroundColor(.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
