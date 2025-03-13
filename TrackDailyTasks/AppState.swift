//
//  AppState.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

// MARK: - App State (Centralized State Container)
class AppState: ObservableObject {
    // Domain Layer Dependencies
    private let taskUseCase: TaskUseCaseProtocol
    private let dateNavigationUseCase: DateNavigationUseCaseProtocol
    private let themeUseCase: ThemeUseCaseProtocol
    
    // Published State
    @Published var currentDate: Date
    @Published var tasks: [Task] = []
    @Published var theme: Theme
    
    init(
        taskUseCase: TaskUseCaseProtocol,
        dateNavigationUseCase: DateNavigationUseCaseProtocol,
        themeUseCase: ThemeUseCaseProtocol
    ) {
        self.taskUseCase = taskUseCase
        self.dateNavigationUseCase = dateNavigationUseCase
        self.themeUseCase = themeUseCase
        
        // Initialize state with data from use cases
        self.currentDate = dateNavigationUseCase.getCurrentDate()
        self.theme = themeUseCase.getCurrentTheme()
        
        // Load initial tasks
        loadTasks()
    }
    
    // MARK: - Task Operations
    
    func loadTasks() {
        tasks = taskUseCase.getTasks(for: currentDate)
    }
    
    func addTask(_ task: Task) {
        taskUseCase.addTask(task)
        loadTasks()
    }
    
    func updateTask(_ task: Task) {
        taskUseCase.updateTask(task)
        loadTasks()
    }
    
    func deleteTask(_ task: Task) {
        taskUseCase.deleteTask(task)
        loadTasks()
    }
    
    // MARK: - Date Navigation
    
    func moveToNextDay() {
        currentDate = dateNavigationUseCase.getNextDay(from: currentDate)
        loadTasks()
    }
    
    func moveToPreviousDay() {
        currentDate = dateNavigationUseCase.getPreviousDay(from: currentDate)
        loadTasks()
    }
    
    func moveToToday() {
        currentDate = dateNavigationUseCase.getCurrentDate()
        loadTasks()
    }
    
    // MARK: - Theme
    
    func toggleTheme() {
        theme = themeUseCase.toggleTheme()
    }
    
    func setTheme(_ newTheme: Theme) {
        theme = themeUseCase.setTheme(newTheme)
    }
}
