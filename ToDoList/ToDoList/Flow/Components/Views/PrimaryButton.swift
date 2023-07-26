//
//  ButtonView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct PrimaryButton: View {
    
    @State var title: String
    @State var width: CGFloat = ScreenSize.width - 100
    @State var height: CGFloat = ScreenSize.width/6
    @State var action: () -> Void

    
    var body: some View {
        Button(action: action) {
            ZStack (alignment: .center) {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.blue)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.top)
            .frame(width: width,
                   height: height)
        }
    }

}

