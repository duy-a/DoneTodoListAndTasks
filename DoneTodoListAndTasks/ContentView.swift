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
                    case .all: TaskList()
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
