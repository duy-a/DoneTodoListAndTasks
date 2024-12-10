//
//  TaskForm.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 5/12/24.
//

import SwiftData
import SwiftUI

struct TaskForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var task: Task
    
    @State private var hasDueDate: Bool = false
    @State private var dueDate: Date = .now
    
    @State private var isShowingTaskDeleteConfirmation: Bool = false
    
    init(task: Task) {
        self.task = task
        
        if let dueDate = task.dueDate {
            self._hasDueDate = State(wrappedValue: true)
            self._dueDate = State(wrappedValue: dueDate)
        }
    }
    
    var body: some View {
        Form {
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

                TextField("Title", text: $task.title)
            }
            
            Toggle("Due date", isOn: $hasDueDate.animation())
                .onChange(of: hasDueDate) {
                    if hasDueDate {
                        task.dueDate = dueDate
                    } else {
                        task.dueDate = nil
                    }
                }
            
            if hasDueDate {
                DatePicker("Task due date", selection: $dueDate)
                    .datePickerStyle(.graphical)
                    .onChange(of: dueDate) {
                        task.dueDate = dueDate
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    if task.title.isEmpty {
                        deleteTask()
                    }

                    dismiss()
                } label: {
                    // not using Label() because swiftui is hiding text
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
            
            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    isShowingTaskDeleteConfirmation = true
                } label: {
                    Label("Delete task", systemImage: "trash")
                        .labelStyle(.iconOnly)
                }
                .tint(.red)
                .disabled(task.title.isEmpty)
            }
        }
        .alert(isPresented: $isShowingTaskDeleteConfirmation) {
            Alert(title: Text("Are you sure?"),
                  message: Text("Cannot undo this action"),
                  primaryButton: .destructive(Text("Delete"), action: deleteTask),
                  secondaryButton: .cancel())
        }
    }
    
    func deleteTask() {
        modelContext.delete(task)
        dismiss()
    }
}

#Preview {
    let exampleTask = Task(title: "Example", dueDate: .now, isCompleted: false)
        
    NavigationStack {
        TaskForm(task: exampleTask)
            .modelContainer(StoreProvider.previewContainer)
    }
}
