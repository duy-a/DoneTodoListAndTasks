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

    @State private var sortOder: Task.SortOder = .byDueDate

    init(listCategory: ListCategory) {
        let today = Calendar.current.startOfDay(for: .now)
        
        switch listCategory {
        case .all:
            return
        case .today:
            self._tasks = Query(filter: #Predicate {
                $0.dueDate == today
            })
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                switch sortOder {
                case .byDueDate:
                    TaskSortByDue(tasks: tasks)
                case .byTitle:
                    TaskSortByTitle(tasks: tasks)
                }
            }
            .navigationDestination(for: Task.self, destination: TaskDetails.init)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Menu("Sort Order", systemImage: "arrow.up.arrow.down.circle") {
                        Picker("Sort by", selection: $sortOder.animation()) {
                            Text("Due date").tag(Task.SortOder.byDueDate)
                            Text("Title").tag(Task.SortOder.byTitle)
                        }
                    }
                }

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
}

#Preview {
    TaskList(listCategory: .all)
        .modelContainer(StoreProvider.previewContainer)
}
