//
//  TrackDailyTasksApp.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

@main
struct TrackDailyTasksApp: App {
    @StateObject private var appState: AppState
        
    init() {
        // MARK: - Dependency Injection
        
        // Data Layer
        let taskRepository: TaskRepositoryProtocol = UserDefaultsTaskRepository()
        
        // Domain Layer - Use Cases
        let taskUseCase: TaskUseCaseProtocol = TaskUseCase(repository: taskRepository)
        let dateNavigationUseCase: DateNavigationUseCaseProtocol = DateNavigationUseCase()
        let themeUseCase: ThemeUseCaseProtocol = ThemeUseCase()
        
        // Presentation Layer - App State
        let appState = AppState(
            taskUseCase: taskUseCase,
            dateNavigationUseCase: dateNavigationUseCase,
            themeUseCase: themeUseCase
        )
        
        _appState = StateObject(wrappedValue: appState)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(appState.theme.isDarkMode ? .dark : .light)
                .accentColor(appState.theme.accentColor)
        }
    }
}
