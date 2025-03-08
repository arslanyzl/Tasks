//
//  TasksApp.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import SwiftUI

@main
struct TasksApp: App {
    let repository = TaskRepositoryImpl()
    
    var body: some Scene {
        WindowGroup {
            // Set up the chain of dependencies
            let getTasksUseCase = GetTasksUseCaseImpl(repository: repository)
            let addTaskUseCase = AddTaskUseCaseImpl(repository: repository)
            let updateTaskUseCase = UpdateTaskUseCaseImpl(repository: repository)
            
            let presenter = TaskListPresenter(
                getTasksUseCase: getTasksUseCase,
                addTaskUseCase: addTaskUseCase,
                updateTaskUseCase: updateTaskUseCase
            )
            
            let viewModel = TaskListViewModel(presenter: presenter)
            
            // Create the main view with injected dependencies
            TaskListView(
                getTasksUseCase: getTasksUseCase,
                addTaskUseCase: addTaskUseCase,
                updateTaskUseCase: updateTaskUseCase
            )
        }
    }
}
