//
//  TaskSortByDue.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 15/12/24.
//

import SwiftData
import SwiftUI

struct TaskSortByDue: View {
    private var tasksWithDue: [Task] = []
    private var tasksWithoutDue: [Task] = []
    
    private var groupedByDueDate: [Date: [Task]] = [:]
    private var sortedDates: [Date] = []
    
    init(tasks: [Task]) {
        self.tasksWithDue = tasks
            .filter { $0.dueDate != nil }
        
        self.groupedByDueDate = Dictionary(grouping: tasksWithDue, by: { $0.dueDate! })
        self.sortedDates = groupedByDueDate.keys.sorted()
        
        self.tasksWithoutDue = tasks
            .filter { $0.dueDate == nil }
            .sorted { $0.title < $1.title }
    }
    
    var body: some View {
        List {
            ForEach(sortedDates, id: \.self) { date in
                let sortedTasks = groupedByDueDate[date]!.sorted { lhs, rhs in
                    if lhs.dueTime == nil && rhs.dueTime != nil {
                        return true
                    } else if lhs.dueTime != nil && rhs.dueTime == nil {
                        return false
                    } else if lhs.dueTime == nil && rhs.dueTime == nil {
                        return lhs.title < rhs.title
                    }
                    
                    return lhs.dueTime! < rhs.dueTime!
                }
                
                ForEach(sortedTasks) { task in
                    TaskListItem(task: task)
                }
            }
            
            ForEach(tasksWithoutDue) { task in
                TaskListItem(task: task)
            }
        }
    }
}

#Preview {
    TaskSortByDue(tasks: Task.sampleData)
}
