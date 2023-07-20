//
//  ButtonView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-12.
//

import SwiftUI

struct PrimaryButton: View {
    
    @State var title: String
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
            .frame(width: ScreenSize.width - 100,
                   height: ScreenSize.width/6)
        }
    }
}
