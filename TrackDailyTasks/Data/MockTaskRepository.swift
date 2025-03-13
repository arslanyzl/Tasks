//
//  MockTaskRepository.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class MockTaskRepository: TaskRepositoryProtocol {
    private var tasks: [Task] = []
    
    init(withSampleData: Bool = false) {
        if withSampleData {
            let today = Date()
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            
            tasks = [
                Task(title: "Complete project", description: "Add more features", date: today, isCompleted: true, priority: .high),
                Task(title: "Buy groceries", date: today, priority: .medium),
                Task(title: "Go for a run", date: today, priority: .low),
                Task(title: "Read book", date: yesterday, priority: .medium),
                Task(title: "Team meeting", date: tomorrow, priority: .high)
            ]
        }
    }
    
    func getAllTasks() -> [Task] {
        return tasks
    }
    
    func saveTask(_ task: Task) {
        tasks.append(task)
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
}
