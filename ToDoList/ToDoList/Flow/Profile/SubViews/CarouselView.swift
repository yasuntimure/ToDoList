//
//  CarouselView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-25.
//

import SwiftUI

struct CarouselView: View {

    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.items) { item in
                    CarouselItem(item: item)
                        .frame(width: ScreenSize.width-150, height: 200)
                        .shadow(radius: 3)
                }
            }
            .padding()
        }
    }
}

struct CarouselItem: View {

    @State var progressPercent: Float = 0.2

    @State var item: ToDoListItemModel

    var body: some View {

        ZStack {
            GradientView(mColor: .secondary)

            VStack (alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.description)
                    .font(.body)
                ProgressBar(value: $progressPercent)
                    .frame(width: ScreenSize.width/3, height: 10)
            }
        }
        .cornerRadius(15)
    }
}



struct ProgressBar: View {

    @Binding var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width ,
                           height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width),
                           height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemTeal))

            }
        }
        .cornerRadius(45.0)
    }
}



struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
