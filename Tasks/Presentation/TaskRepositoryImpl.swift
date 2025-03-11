//
//  TaskListPresenterProtocol.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

class TaskRepositoryImpl: TaskRepository {
    func toggleTaskCompletion(task: Task) {
        var tasks = getTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            save(tasks)
        }
    }
    private let storageKey = "tasks"
    
    func getTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return []
        }
        return tasks
    }
    
    func addTask(_ task: Task) {
        var tasks = getTasks()
        tasks.append(task)
        save(tasks)
    }
    
    func updateTask(_ task: Task) {
        var tasks = getTasks().map { $0.id == task.id ? task : $0 }
        save(tasks)
    }
    
    private func save(_ tasks: [Task]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}
