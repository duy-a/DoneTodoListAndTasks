//
//  ContentView.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 23/11/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                Text("Here will be filters all or today")
                NavigationLink("All tasks", value: 1)
            }
        }
        detail: {
            TaskList()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(StoreProvider.previewContainer)
}
