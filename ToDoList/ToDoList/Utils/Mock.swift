//
//  Mock.swift
//  ToDoList
//
//  Created by Eyüp on 2023-09-23.
//

struct Mock {

    static let lists: [ToDoListModel] = [list1,list2,list3,list4]

    static let list1: ToDoListModel = ToDoListModel(title: "List Item 1",
                                                    items: [item1, item2, item3])
    static let list2: ToDoListModel = ToDoListModel(title: "List Item 2")
    static let list3: ToDoListModel = ToDoListModel(title: "List Item 3")
    static let list4: ToDoListModel = ToDoListModel(title: "List Item 4")


    static let item1: ToDoListItemModel = ToDoListItemModel(title: "ToDoListItem title 1")
    static let item2: ToDoListItemModel = ToDoListItemModel(title: "ToDoListItem title 2")
    static let item3: ToDoListItemModel = ToDoListItemModel(title: "ToDoListItem title 3")
}

