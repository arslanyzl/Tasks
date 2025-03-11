//
//  Task.swift
//  Task
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, description: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}
