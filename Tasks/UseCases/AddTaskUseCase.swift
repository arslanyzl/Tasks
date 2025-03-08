//
//  AddTaskUseCase.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


protocol AddTaskUseCase {
    func execute(task: Task) -> Bool
}

class AddTaskUseCaseImpl: AddTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(task: Task) -> Bool {
        return repository.addTask(task: task)
    }
}