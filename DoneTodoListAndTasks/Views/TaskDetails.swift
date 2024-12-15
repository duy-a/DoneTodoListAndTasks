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
    
    @State private var hasDueTime: Bool = false
    @State private var showingTimePicker: Bool = false
    @State private var dueTime: Date = .now
    
    init(task: Task) {
        self.task = task
        
        if let dueDate = task.dueDate {
            self._hasDueDate = State(wrappedValue: true)
            self._dueDate = State(wrappedValue: dueDate)
        }
        
        if let dueTime = task.dueTime {
            self._hasDueTime = State(wrappedValue: true)
            self._dueTime = State(wrappedValue: dueTime)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $task.title)
            }
            
            Section {
                HStack {
                    Label("Due date", systemImage: "calendar.circle.fill")
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
                            if !showingTimePicker {
                                showingDatePicker = true
                            }
                            task.setDueDate(date: dueDate)
                        } else {
                            showingDatePicker = false
                            dueDate = .now
                            task.setDueDate(date: nil)
                            
                            hasDueTime = false
                            task.setDueTime(time: nil)
                        }
                    }
                }
                
                if showingDatePicker {
                    DatePicker("Task due date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .onChange(of: dueDate) {
                            task.setDueDate(date: dueDate)
                        }
                        .transition(.move(edge: .bottom))
                }
                
                HStack {
                    Label("Due time", systemImage: "clock.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.title)
                        .labelStyle(.iconOnly)
             
                    Toggle(isOn: $hasDueTime.animation()) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Due time")
                        
                            if hasDueTime {
                                Button {
                                    withAnimation {
                                        showingTimePicker.toggle()
                                    }
                                } label: {
                                    Text(dueTime, format: .dateTime.hour().minute())
                                }
                                .font(.footnote)
                                .buttonStyle(.plain)
                                .foregroundStyle(.blue)
                            }
                        }
                    }
                    .onChange(of: hasDueTime) {
                        if hasDueTime {
                            hasDueDate = true
                            
                            showingTimePicker = true
                            task.setDueTime(time: dueTime)
                        } else {
                            showingTimePicker = false
                            dueTime = .now
                            task.setDueTime(time: nil)
                        }
                    }
                }
                
                if showingTimePicker {
                    DatePicker("Task due time", selection: $dueTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .onChange(of: dueTime) {
                            task.setDueTime(time: dueTime)
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
    NavigationStack {
        TaskDetails(task: Task.sampleData[0])
            .modelContainer(StoreProvider.previewContainer)
    }
}
