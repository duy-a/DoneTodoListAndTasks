//
//  TaskList.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 9/12/24.
//

import SwiftData
import SwiftUI

struct TaskList: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var tasks: [Task]

    @State private var path = [Task]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(tasks) { task in
                    TaskListItem(task: task)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationDestination(for: Task.self, destination: TaskDetails.init)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()

                    Button {
                        let newTask = Task()
                        modelContext.insert(newTask)
                        path = [newTask]
                    } label: {
                        HStack(alignment: .center) {
                            Image(systemName: "plus.circle.fill")
                            Text("New Task")
                        }
                    }
                }
            }
        }
    }

    func deleteTask(_ indexSet: IndexSet) {
        for i in indexSet {
            let taskToDelete = tasks[i]
            modelContext.delete(taskToDelete)
        }
    }
}

#Preview {
    TaskList()
        .modelContainer(StoreProvider.previewContainer)
}
