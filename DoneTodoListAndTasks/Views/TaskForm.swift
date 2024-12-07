//
//  TaskForm.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 5/12/24.
//

import SwiftUI

struct TaskForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var hasDueDate: Bool = false
    @State private var dueDate: Date = .now
    @State private var isCompleted: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task name", text: $title)
                Toggle("Due date", isOn: $hasDueDate.animation())
                if hasDueDate {
                    DatePicker("Due date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
            }
            .navigationTitle("Add Task")
            .navigationBarBackButtonHidden()
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newTask = Task()
                        newTask.title = title
                        newTask.dueDate = hasDueDate ? dueDate : nil
                        newTask.isCompleted = isCompleted

                        modelContext.insert(newTask)

                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TaskForm()
}
