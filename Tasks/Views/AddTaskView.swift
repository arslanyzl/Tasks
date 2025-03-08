//
//  AddTaskView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


// AddTaskView.swift
import SwiftUI

struct AddTaskView: View {
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var description: String
    let onAdd: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        onAdd()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(
        isPresented: .constant(true),
        title: .constant("New Task"),
        description: .constant("Task description goes here"),
        onAdd: {}
    )
}
