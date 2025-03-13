//
//  ContentView.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                DateNavigationView()
                    .padding()
                
                TaskListView()
                
                Spacer()
            }
            .navigationTitle("Task List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        appState.toggleTheme()
                    }) {
                        Image(systemName: appState.theme.isDarkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                TaskEditView(task: nil) { newTask in
                    if let task = newTask {
                        appState.addTask(task)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRepository = MockTaskRepository(withSampleData: true)
        let taskUseCase = TaskUseCase(repository: mockRepository)
        let dateNavigationUseCase = DateNavigationUseCase()
        let themeUseCase = ThemeUseCase()
        
        let appState = AppState(
            taskUseCase: taskUseCase,
            dateNavigationUseCase: dateNavigationUseCase,
            themeUseCase: themeUseCase
        )
        
        return ContentView()
            .environmentObject(appState)
    }
}
