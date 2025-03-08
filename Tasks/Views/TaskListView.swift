//
//  TaskListView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


import SwiftUI

// Updated TaskListView.swift
import SwiftUI

struct TaskListView: View {
    // State management
    @State private var tasks: [Task] = []
    @State private var showingAddTask = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    
    // Use cases
    private let getTasksUseCase: GetTasksUseCase
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    
    init(getTasksUseCase: GetTasksUseCase,
         addTaskUseCase: AddTaskUseCase,
         updateTaskUseCase: UpdateTaskUseCase) {
        self.getTasksUseCase = getTasksUseCase
        self.addTaskUseCase = addTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    NavigationLink(destination: TaskView(
                        task: task,
                        onToggleCompletion: toggleTaskCompletion
                    )) {
                        TaskRow(task: task) {
                            toggleTaskCompletion(task: task)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(
                    isPresented: $showingAddTask,
                    title: $newTaskTitle,
                    description: $newTaskDescription,
                    onAdd: {
                        if !newTaskTitle.isEmpty {
                            addTask()
                        }
                    }
                )
            }
            .onAppear {
                loadTasks()
            }
        }
    }
    
    // Use case execution functions
    private func loadTasks() {
        tasks = getTasksUseCase.execute()
    }
    
    private func addTask() {
        let newTask = Task(title: newTaskTitle, description: newTaskDescription)
        let success = addTaskUseCase.execute(task: newTask)
        
        if success {
            newTaskTitle = ""
            newTaskDescription = ""
            showingAddTask = false
            loadTasks()
        }
    }
    
    private func toggleTaskCompletion(task: Task) {
        var updatedTask = task
        updatedTask.isCompleted.toggle()
        
        let success = updateTaskUseCase.execute(task: updatedTask)
        
        if success {
            loadTasks()
        }
    }
}

#Preview {
    class MockGetTasksUseCase: GetTasksUseCase {
        func execute() -> [Task] {
            return [
                Task(id: UUID(), title: "Learn Clean Architecture", description: "Study the principles", isCompleted: false),
                Task(id: UUID(), title: "Implement SwiftUI App", description: "Create a sample app", isCompleted: true),
                Task(id: UUID(), title: "Write Unit Tests", description: "Test all components", isCompleted: false)
            ]
        }
    }

    class MockAddTaskUseCase: AddTaskUseCase {
        func execute(task: Task) -> Bool {
            return true
        }
    }

    class MockUpdateTaskUseCase: UpdateTaskUseCase {
        func execute(task: Task) -> Bool {
            return true
        }
    }
    
    return TaskListView(
        getTasksUseCase: MockGetTasksUseCase(),
        addTaskUseCase: MockAddTaskUseCase(),
        updateTaskUseCase: MockUpdateTaskUseCase()
    )
}
