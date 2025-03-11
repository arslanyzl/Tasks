//
//  TaskRepository.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

protocol TaskRepository {
    func toggleTaskCompletion(task: Task)
    func getTasks() -> [Task]
    func addTask(_ task: Task)
    func updateTask(_ task: Task)
}
