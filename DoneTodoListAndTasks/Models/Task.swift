//
//  Task.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 4/12/24.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    var dueDate: Date?
    var isCompleted: Bool

    init(title: String = "", dueDate: Date? = nil, isCompleted: Bool = false) {
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
