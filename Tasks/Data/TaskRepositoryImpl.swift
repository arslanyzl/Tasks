//
//  TaskRepositoryImpl.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

class TaskRepositoryImpl: TaskRepository {
    private var tasks: [Task] = [
        Task(title: "Learn Clean Architecture", description: "Study the principles of Clean Architecture", isCompleted: false),
        Task(title: "Implement UseCase pattern", description: "Use the UseCase pattern in my next app", isCompleted: false)
    ]
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func addTask(task: Task) -> Bool {
        tasks.append(task)
        return true
    }
    
    func updateTask(task: Task) -> Bool {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            return true
        }
        return false
    }
    
    func deleteTask(id: UUID) -> Bool {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks.remove(at: index)
            return true
        }
        return false
    }
}
