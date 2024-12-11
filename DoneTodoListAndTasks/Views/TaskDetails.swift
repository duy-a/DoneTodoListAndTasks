//
//  TaskDetails.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 5/12/24.
//

import SwiftData
import SwiftUI

struct TaskDetails: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var task: Task
    
    @State private var hasDueDate: Bool = false
    @State private var showingDatePicker: Bool = false
    @State private var dueDate: Date = .now
    
    init(task: Task) {
        self.task = task
        
        if let dueDate = task.dueDate {
            self._hasDueDate = State(wrappedValue: true)
            self._dueDate = State(wrappedValue: dueDate)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $task.title)
            }
            
            Section {
                HStack {
                    Label("Test", systemImage: "calendar.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.title)
                        .labelStyle(.iconOnly)
                 
                    Toggle(isOn: $hasDueDate.animation()) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Due date")
                            
                            if hasDueDate {
                                Button {
                                    withAnimation {
                                        showingDatePicker.toggle()
                                    }
                                } label: {
                                    Text(dueDate, format: .dateTime.day().month(.defaultDigits).year())
                                }
                                .font(.footnote)
                                .buttonStyle(.plain)
                                .foregroundStyle(.blue)
                            }
                        }
                    }
                    .onChange(of: hasDueDate) {
                        if hasDueDate {
                            showingDatePicker = true
                            task.dueDate = dueDate
                        } else {
                            showingDatePicker = false
                            task.dueDate = nil
                        }
                    }
                }
                
                if showingDatePicker {
                    DatePicker("Task due date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .onChange(of: dueDate) {
                            task.dueDate = dueDate
                        }
                        .transition(.move(edge: .bottom))
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
                    deleteTask()
                } label: {
                    Label("Delete task", systemImage: "trash")
                        .labelStyle(.iconOnly)
                }
                .tint(.red)
                .disabled(task.title.isEmpty)
            }
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
        TaskDetails(task: exampleTask)
            .modelContainer(StoreProvider.previewContainer)
    }
}
