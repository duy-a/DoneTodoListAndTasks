//
//  TaskSortByTitle.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 15/12/24.
//

import SwiftData
import SwiftUI

struct TaskSortByTitle: View {
    var tasks: [Task]

    init(tasks: [Task]) {
        self.tasks = tasks.sorted(by: { $0.title < $1.title })
    }

    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskListItem(task: task)
            }
        }
    }
}

#Preview {
    TaskSortByTitle(tasks: Task.sampleData)
}
