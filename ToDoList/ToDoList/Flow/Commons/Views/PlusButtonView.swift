//
//  ButtonView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-18.
//

import SwiftUI

struct PlusButtonView: View {

    var size: CGFloat = 20

    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack (alignment: .center) {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: size/5,
                           height: size)
                    .cornerRadius(5)

                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: size,
                           height: size/5)
                    .cornerRadius(5)
            }
        }
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView {}
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
