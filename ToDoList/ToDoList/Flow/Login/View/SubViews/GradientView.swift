//
//  GradientView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct GradientView: View {

    @State var mColor: Color = .blue

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [mColor, mColor.opacity(0.1)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .grayscale(0.2)
        .edgesIgnoringSafeArea(.all)
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
