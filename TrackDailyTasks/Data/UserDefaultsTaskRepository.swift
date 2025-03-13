//
//  UserDefaultsTaskRepository 2.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class UserDefaultsTaskRepository: TaskRepositoryProtocol {
    private let userDefaults = UserDefaults.standard
    private let tasksKey = "saved_tasks"
    
    func getAllTasks() -> [Task] {
        guard let data = userDefaults.data(forKey: tasksKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error decoding tasks: \(error)")
            return []
        }
    }
    
    func saveTask(_ task: Task) {
        var tasks = getAllTasks()
        tasks.append(task)
        saveTasks(tasks)
    }
    
    func updateTask(_ task: Task) {
        var tasks = getAllTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks(tasks)
        }
    }
    
    func deleteTask(_ task: Task) {
        var tasks = getAllTasks()
        tasks.removeAll { $0.id == task.id }
        saveTasks(tasks)
    }
    
    private func saveTasks(_ tasks: [Task]) {
        do {
            let data = try JSONEncoder().encode(tasks)
            userDefaults.set(data, forKey: tasksKey)
        } catch {
            print("Error encoding tasks: \(error)")
        }
    }
}
