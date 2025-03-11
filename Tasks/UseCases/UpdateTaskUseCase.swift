//
//  UpdateTaskUseCase.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


class UpdateTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Task) {
        repository.updateTask(task)
    }
}
