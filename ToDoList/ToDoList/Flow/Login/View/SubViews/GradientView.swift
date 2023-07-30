//
//  GradientView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct GradientView: View {

    @State var mColor: Color = .gray

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [mColor.opacity(0.15), mColor.opacity(0.0)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
