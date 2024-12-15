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
            HStack(spacing: 10) {
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
                    
                    HStack(spacing: 5) {
                        if let dueDate = task.dueDate {
                            Text(dueDate, format: .dateTime.day().month(.twoDigits).year())
                        }
                        
                        if let dueTime = task.dueTime {
                            Text(dueTime, format: .dateTime.hour().minute())
                        }
                        
                    }
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                    
                }
            }
        }
        .transition(.move(edge: .bottom))
    }
}

 #Preview {
     NavigationStack {
         List {
             TaskListItem(task: Task.sampleData.randomElement()!)
                 .modelContainer(StoreProvider.previewContainer)
         }
     }
 }
