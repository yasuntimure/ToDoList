//
//  HeaderView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct HeaderView: View {

    @Environment (\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
            Image("logo")
                .resizable()
                .frame(width: ScreenSize.width/1.6, height: ScreenSize.width/1.6)
                .cornerRadius(ScreenSize.width)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fill)
                .padding(.top, ScreenSize.width/3.5)
                .shadow(
                    color: colorScheme == .light ? .black : .white,
                    radius: 8
                )
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
