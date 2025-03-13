//
//  TaskUseCase.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class TaskUseCase: TaskUseCaseProtocol {
    private let repository: TaskRepositoryProtocol
    
    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTasks(for date: Date) -> [Task] {
        let calendar = Calendar.current
        return repository.getAllTasks().filter { task in
            calendar.isDate(task.date, inSameDayAs: date)
        }
    }
    
    func addTask(_ task: Task) {
        repository.saveTask(task)
    }
    
    func updateTask(_ task: Task) {
        repository.updateTask(task)
    }
    
    func deleteTask(_ task: Task) {
        repository.deleteTask(task)
    }
}
