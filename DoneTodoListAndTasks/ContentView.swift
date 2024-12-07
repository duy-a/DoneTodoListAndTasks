//
//  ContentView.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 23/11/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]

    @State private var isShowingTaskForm: Bool = false

    var body: some View {
        NavigationSplitView {
            List {
                Text("Here will be filters all or today")
                NavigationLink("All tasks", value: 1)
            }
            .navigationDestination(for: Int.self) { _ in
                List {
                    ForEach(tasks) { task in
                        VStack {
                            Text(task.title)
                            if let dueDate = task.dueDate {
                                Text(dueDate, style: .date)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingTaskForm) {
                    TaskForm()
                }
                .navigationTitle("All tasks")
                .toolbar {
                    Button {
                        isShowingTaskForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .toolbar(removing: .sidebarToggle)
        } detail: {
            Text("Select a filter")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(StoreProvider.previewContainer)
}
