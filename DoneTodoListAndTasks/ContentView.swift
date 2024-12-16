//
//  ContentView.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 23/11/24.
//

import SwiftData
import SwiftUI

enum ListCategory: String, CaseIterable {
    case all
    case today
}

struct ContentView: View {
    @State private var selectedList: ListCategory? = nil

    var body: some View {
        NavigationSplitView {
            List(ListCategory.allCases, id: \.self, selection: $selectedList) { category in
                NavigationLink(category.rawValue, value: category)
            }
        }
        detail: {
            if let selectedList {
                switch selectedList {
                case .all: TaskList(listCategory: .all)
                case .today: TaskList(listCategory: .today)
                }
            } else {
                Text("Please selected a list")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(StoreProvider.previewContainer)
}
