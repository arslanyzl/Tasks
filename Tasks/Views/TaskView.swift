//
//  TaskView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


import SwiftUI

struct TaskView: View {
    let task: Task
    let onToggleCompletion: (Task) -> Void
    let onUpdateTask: (Task) -> Void
    
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedDescription: String
    @State private var showAddTaskView = false // State variable to manage navigation
    
    init(task: Task, onToggleCompletion: @escaping (Task) -> Void, onUpdateTask: @escaping (Task) -> Void) {
        self.task = task
        self.onToggleCompletion = onToggleCompletion
        self.onUpdateTask = onUpdateTask
        _editedTitle = State(initialValue: task.title)
        _editedDescription = State(initialValue: task.description)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(task.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    onToggleCompletion(task)
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .imageScale(.large)
                }
            }
            Divider()
            Text("Description")
                .font(.headline)
            Text(task.description)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showAddTaskView.toggle() // Trigger the state change to show AddTaskView
                }
            }
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView(
                isPresented: $showAddTaskView,
                taskToEdit: task,
                onSave: { updatedTask in
                    onUpdateTask(updatedTask)
                }
            )
        }
    }
}

#Preview {
    NavigationView {
        TaskView(
            task: Task(
                id: UUID(),
                title: "Learn Clean Architecture",
                description: "Study the principles of Clean Architecture and implement a simple app using the MVVM pattern with use cases.",
                isCompleted: false
            ),
            onToggleCompletion: { _ in },
            onUpdateTask: { _ in }
        )
    }
    
    NavigationView {
        TaskView(
            task: Task(
                id: UUID(),
                title: "Implement SwiftUI App",
                description: "Create a SwiftUI app that demonstrates Clean Architecture principles with use cases.",
                isCompleted: true
            ),
            onToggleCompletion: { _ in },
            onUpdateTask: { _ in }
        )
    }
}
