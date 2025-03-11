//
//  AddTaskUseCase.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

class AddTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(title: String, description: String) {
        let task = Task(id: UUID(), title: title, description: description)
        repository.addTask(task)
    }
}
