//
//  HeaderView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-11.
//

import SwiftUI

struct HeaderView: View {

    @Environment (\.colorScheme) var colorScheme: ColorScheme

    @State var state: Bool = true

    var body: some View {
        HStack (spacing: 10) {
            ToggleButton(state: $state)
                .frame(width: ScreenSize.width/4.6)

            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text("To Do")
                        .font(.system(size: 52)).bold()
                        .foregroundColor(.primary)
                        .minimumScaleFactor(0.01)
                    Text("List")
                        .font(.system(size: 52)).bold()
                        .foregroundColor(.mTintColor)
                        .minimumScaleFactor(0.01)
                }

                Text("Easy to check!")
                    .font(.system(size: 30)).bold()
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .minimumScaleFactor(0.01)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .frame(width: ScreenSize.width - 50, height: 100)
    }
}
