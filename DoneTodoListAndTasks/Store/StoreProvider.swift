//
//  StoreProvider.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 3/12/24.
//

import SwiftData

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
        let storeProvide: StoreProvider = .init(inMemory: true)

        return storeProvide.modelContainer
    }()
}
