//
//  TaskRepository.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

protocol TaskRepository {
    func getTasks() -> [Task]
    func addTask(task: Task) -> Bool
    func updateTask(task: Task) -> Bool
    func deleteTask(id: UUID) -> Bool
}
