//
//  TaskListView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel: TaskListViewModel
    @State private var showingAddTask = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    
    init() {
        let repository = TaskRepositoryImpl()
        let getTasksUseCase = GetTasksUseCase(repository: repository)
        let addTaskUseCase = AddTaskUseCase(repository: repository)
        let updateTaskUseCase = UpdateTaskUseCase(repository: repository)
        _viewModel = StateObject(wrappedValue: TaskListViewModel(getTasksUseCase: getTasksUseCase, addTaskUseCase: addTaskUseCase, updateTaskUseCase: updateTaskUseCase))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: TaskView(task: task, onToggleCompletion: { updatedTask in
                        viewModel.toggleTaskCompletion(updatedTask)
                    }, onUpdateTask: { updatedTask in
                        viewModel.updateTask(updatedTask)
                    })) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title).font(.headline)
                                Text(task.description).font(.subheadline)
                            }
                            Spacer()
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
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
                    onSave: { task in
                        viewModel.addTask(
                            title: task.title,
                            description: task.description
                        )
                        showingAddTask = false
                    }
                )
            }
        }
    }
}

// MARK: - Preview
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
