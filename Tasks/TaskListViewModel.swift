//
//  TaskListViewModel.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    private let getTasksUseCase: GetTasksUseCase
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    
    init(getTasksUseCase: GetTasksUseCase, addTaskUseCase: AddTaskUseCase, updateTaskUseCase: UpdateTaskUseCase) {
        self.getTasksUseCase = getTasksUseCase
        self.addTaskUseCase = addTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
        loadTasks()
    }
    
    func loadTasks() {
        tasks = getTasksUseCase.execute()
    }
    
    func addTask(title: String, description: String) {
        addTaskUseCase.execute(title: title, description: description)
        loadTasks()
    }
    
    func updateTask(_ task: Task) {
        updateTaskUseCase.execute(task: task)
        loadTasks()
    }
    
    func toggleTaskCompletion(_ task: Task) {
        var updatedTask = task
        updatedTask.isCompleted.toggle()
        updateTask(updatedTask)
    }
}
