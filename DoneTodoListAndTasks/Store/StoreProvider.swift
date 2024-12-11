//
//  StoreProvider.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 3/12/24.
//

import Foundation
import SwiftData

@MainActor
class StoreProvider {
    static let shared: StoreProvider = .init()

    private let schema = Schema([
        Task.self,
    ])

    let modelContainer: ModelContainer

    init(inMemory: Bool = false) {
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

// Container used for preview
extension StoreProvider {
    static let previewContainer: ModelContainer = {
        let storeProvider: StoreProvider = .init(inMemory: true)

        for i in 1 ..< 10 {
            let task = Task(title: "Task \(i)",
                            dueDate: Bool.random() ? Calendar.current.date(byAdding: .day, value: i, to: .now) : nil, isCompleted:
                            Bool.random())

            storeProvider.modelContainer.mainContext.insert(task)
        }

        return storeProvider.modelContainer
    }()
}
