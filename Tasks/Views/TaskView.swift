//
//  TaskView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


// TaskView.swift
import SwiftUI

struct TaskView: View {
    let task: Task
    let onToggleCompletion: (Task) -> Void
    
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
            
            if task.isCompleted {
                Text("✓ Completed")
                    .font(.caption)
                    .foregroundColor(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            } else {
                Text("◯ In Progress")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Task Details")
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
            onToggleCompletion: { _ in }
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
            onToggleCompletion: { _ in }
        )
    }
}
