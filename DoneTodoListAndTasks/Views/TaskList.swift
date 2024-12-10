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
    @State private var isShowingTaskDeleteConfirmation: Bool = false
    @State private var taskToDelete: Task? = nil

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(tasks) { task in
                    TaskListItem(task: task)
                }
                .onDelete(perform: getTaskToDelete)
            }
            .navigationDestination(for: Task.self, destination: TaskForm.init)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()

                    Button("New Task") {
                        let newTask = Task()
                        modelContext.insert(newTask)
                        path = [newTask]
                    }
                }
            }
            .alert(isPresented: $isShowingTaskDeleteConfirmation) {
                Alert(title: Text("Are you sure?"),
                      message: Text("Cannot undo this action"),
                      primaryButton: .destructive(Text("Delete"), action: deleteTask),
                      secondaryButton: .cancel { self.taskToDelete = nil })
            }
        }
    }

    func getTaskToDelete(_ indexSet: IndexSet) {
        for i in indexSet {
            self.taskToDelete = tasks[i]
        }
        isShowingTaskDeleteConfirmation = true
    }

    func deleteTask() {
        if let taskToDelete {
            withAnimation {
                modelContext.delete(taskToDelete)
            }
        }
    }
}

#Preview {
    TaskList()
        .modelContainer(StoreProvider.previewContainer)
}
