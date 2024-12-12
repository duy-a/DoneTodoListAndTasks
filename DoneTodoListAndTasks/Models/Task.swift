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
    var dueTime: Date?
    var isCompleted: Bool

    init(title: String = "", dueDate: Date? = nil, dueTime: Date? = nil, isCompleted: Bool = false) {
        self.title = title
        self.dueDate = dueDate
        self.dueTime = dueTime
        self.isCompleted = isCompleted
    }
}
