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
    private(set) var dueDate: Date?
    private(set) var dueTime: Date?
    var isCompleted: Bool

    init(title: String = "", isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }

    func setDueDate(date: Date?) {
        guard let date else {
            self.dueDate = nil
            return
        }

        self.dueDate = Calendar.current.startOfDay(for: date)
    }

    func setDueTime(time: Date?) {
        guard let time else {
            self.dueTime = nil
            return
        }

        guard let dueDate else { return }

        let hour = Calendar.current.component(.hour, from: time)
        let minute = Calendar.current.component(.minute, from: time)

        self.dueTime = Calendar.current.date(bySettingHour: hour, minute: minute, second: 4, of: dueDate)
    }
}

extension Task {
    static let sampleData: [Task] = {
        var tasks: [Task] = []

        for i in 1 ..< 15 {
            let haveDate: Bool = .random()

            let task = Task(title: "Task \(i)", isCompleted: Bool.random())

            if haveDate {
                task.setDueDate(date: Calendar.current.date(byAdding: .day, value: Int.random(in: 0 ... 1), to: .now))

                if Bool.random() {
                    task.setDueTime(time: Calendar.current.date(byAdding: .hour, value: Int.random(in: -5 ... 5), to: .now))
                }
            }

            tasks.append(task)
        }

        return tasks
    }()
}

extension Task {
    enum SortOder {
        case byDueDate
        case byTitle
    }
}

extension [Task] {
    func sortByTitle() -> [Task] {
        return self.sorted {
            $0.title < $1.title
        }
    }
    
    func sortByDueDate() -> [Task] {
        return self.sorted {
            if let date1 = $0.dueDate, let date2 = $1.dueDate {
                if date1 != date2 {
                    return date1 < date2
                }

                if let time1 = $0.dueTime, let time2 = $1.dueTime {
                    return time1 < time2
                }

                return $0.dueTime != nil
            }

            if $0.dueDate != nil {
                return true
            }

            if $1.dueDate == nil {
                return false
            }

            return $0.title < $1.title
        }
    }
}
