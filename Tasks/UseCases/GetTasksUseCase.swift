//
//  GetTasksUseCase.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import Foundation

protocol GetTasksUseCase {
    func execute() -> [Task]
}

class GetTasksUseCaseImpl: GetTasksUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute() -> [Task] {
        return repository.getTasks()
    }
}
