//
//  UpdateTaskUseCase.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


protocol UpdateTaskUseCase {
    func execute(task: Task) -> Bool
}

class UpdateTaskUseCaseImpl: UpdateTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Task) -> Bool {
        return repository.updateTask(task: task)
    }
}
