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
            TaskListView()
        }
    }
}
