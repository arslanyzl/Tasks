//
//  Task.swift
//  TaskManager
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

struct Task: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var date: Date
    var isCompleted: Bool
    var priority: TaskPriority
    
    init(id: UUID = UUID(), title: String, description: String = "", date: Date, isCompleted: Bool = false, priority: TaskPriority = .medium) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.isCompleted = isCompleted
        self.priority = priority
    }
}

enum TaskPriority: String, Codable, CaseIterable {
    case low
    case medium
    case high
}
