//
//  TaskListItem.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 9/12/24.
//

import SwiftData
import SwiftUI

struct TaskListItem: View {
    @Bindable var task: Task

    var body: some View {
        NavigationLink(value: task) {
            HStack {
                Button {
                    withAnimation {
                        task.isCompleted.toggle()
                    }
                } label: {
                    Label("Toggle task completion status", systemImage: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
                .contentTransition(.symbolEffect(.replace))
                
                VStack(alignment: .leading) {
                    Text(task.title)
                    
                    if let dueDate = task.dueDate {
                        Text(dueDate, format: .dateTime)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

// #Preview {
//    TaskListItem()
// }
