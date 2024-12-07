//
//  DoneTodoListAndTasksApp.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 23/11/24.
//

import SwiftData
import SwiftUI

@main
struct DoneTodoListAndTasksApp: App {
    private let storeProvider: StoreProvider = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(storeProvider.modelContainer)
    }
}
