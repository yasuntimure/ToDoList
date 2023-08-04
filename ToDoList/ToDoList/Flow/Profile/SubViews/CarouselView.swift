//
//  CarouselView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-25.
//

import SwiftUI

struct CarouselView: View {

    @State var lists: [ToDoListModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 10) {
                ForEach(lists) { list in
                    CardView(list: list)
                }
            }
            .padding()
        }
    }
}

struct CardView: View {

    @State var list: ToDoListModel

    @Environment (\.colorScheme) var colorScheme: ColorScheme

    var size: CGSize = CGSize(width: ScreenSize.width/1.5, height: ScreenSize.height/6)

    var body: some View {

        HStack{
            VStack (alignment: .leading) {
                Text(list.title)
                    .font(.headline)
                    .padding(.top)
                Text(list.description)
                    .font(.body)
                Spacer()

                ProgressBar(value: getProgressValue())
                    .frame(width: size.width - 30, height: 10)
                    .padding(.bottom)
            }
            .padding(.leading)

            Spacer()
        }
            .frame(width: size.width,
                   height: size.height)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.primary, lineWidth: 2)
            )
    }

    func getProgressValue() -> Float {

        guard !list.items.isEmpty else {
            return 0.0
        }

        let checkedItems = list.items.filter { $0.isDone == true }

        return Float(checkedItems.count / list.items.count)
    }
}



struct ProgressBar: View {

    @State var value: Float

    var body: some View {
        HStack {
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

            Text("\(value)")
        }
    }
}



struct CarouselView_Previews: PreviewProvider {

    static let lists = [ToDoListModel(id: "",
                                      title: "Workout To Do",
                                      description: "No pain no gain!",
                                      items: [ToDoListItemModel(id: "",
                                                                title: "Bench press",
                                                                description: "Minimum to maximum with 5 sets",
                                                                date: Date().timeIntervalSince1970),
                                              ToDoListItemModel(id: "",
                                                                        title: "Bench press",
                                                                        description: "Minimum to maximum with 5 sets",
                                                                date: Date().timeIntervalSince1970),
                                              ToDoListItemModel(id: "",
                                                                        title: "Bench press",
                                                                        description: "Minimum to maximum with 5 sets",
                                                                        date: Date().timeIntervalSince1970),
                                              ToDoListItemModel(id: "",
                                                                        title: "Bench press",
                                                                        description: "Minimum to maximum with 5 sets",
                                                                        date: Date().timeIntervalSince1970)],
                                      date: Date().timeIntervalSince1970),
                        ToDoListModel(id: "",
                                                          title: "Workout To Do",
                                                          description: "No pain no gain!",
                                                          items: [ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                            date: Date().timeIntervalSince1970),
                                                          ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                                    date: Date().timeIntervalSince1970),
                                                          ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                                    date: Date().timeIntervalSince1970)],
                                                          date: Date().timeIntervalSince1970),
                        ToDoListModel(id: "",
                                                          title: "Workout To Do",
                                                          description: "No pain no gain!",
                                                          items: [ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                            date: Date().timeIntervalSince1970),
                                                          ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                                    date: Date().timeIntervalSince1970),
                                                          ToDoListItemModel(id: "",
                                                                                    title: "Bench press",
                                                                                    description: "Minimum to maximum with 5 sets",
                                                                                    date: Date().timeIntervalSince1970)],
                                                          date: Date().timeIntervalSince1970)]

    static var previews: some View {
        CarouselView(lists: lists)

    }
}
