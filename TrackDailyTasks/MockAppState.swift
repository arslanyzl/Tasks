//
//  MockAppState.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class MockAppState: AppState {
    
    // Create a mock AppState with sample data
    static func createWithSampleData() -> MockAppState {
        let mockRepository = MockTaskRepository(withSampleData: true)
        let taskUseCase = MockTaskUseCase(repository: mockRepository)
        let dateNavigationUseCase = MockDateNavigationUseCase()
        let themeUseCase = MockThemeUseCase()
        
        return MockAppState(
            taskUseCase: taskUseCase,
            dateNavigationUseCase: dateNavigationUseCase,
            themeUseCase: themeUseCase
        )
    }
    
    // Create a mock AppState with empty data
    static func createEmpty() -> MockAppState {
        let mockRepository = MockTaskRepository(withSampleData: false)
        let taskUseCase = MockTaskUseCase(repository: mockRepository)
        let dateNavigationUseCase = MockDateNavigationUseCase()
        let themeUseCase = MockThemeUseCase()
        
        return MockAppState(
            taskUseCase: taskUseCase,
            dateNavigationUseCase: dateNavigationUseCase,
            themeUseCase: themeUseCase
        )
    }
}

// MARK: - Mock Use Cases for Testing

class MockTaskUseCase: TaskUseCaseProtocol {
    private let repository: TaskRepositoryProtocol
    
    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTasks(for date: Date) -> [Task] {
        let calendar = Calendar.current
        return repository.getAllTasks().filter { task in
            calendar.isDate(task.date, inSameDayAs: date)
        }
    }
    
    func addTask(_ task: Task) {
        repository.saveTask(task)
    }
    
    func updateTask(_ task: Task) {
        repository.updateTask(task)
    }
    
    func deleteTask(_ task: Task) {
        repository.deleteTask(task)
    }
}

class MockDateNavigationUseCase: DateNavigationUseCaseProtocol {
    // Mock date can be configured for testing specific scenarios
    private var mockCurrentDate: Date = Date()
    
    func setMockCurrentDate(_ date: Date) {
        mockCurrentDate = date
    }
    
    func getCurrentDate() -> Date {
        return mockCurrentDate
    }
    
    func getNextDay(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
    }
    
    func getPreviousDay(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    }
}

class MockThemeUseCase: ThemeUseCaseProtocol {
    private var currentTheme = Theme(isDarkMode: false, accentColor: .blue)
    
    func getCurrentTheme() -> Theme {
        return currentTheme
    }
    
    func toggleTheme() -> Theme {
        currentTheme.isDarkMode.toggle()
        return currentTheme
    }
    
    func setTheme(_ theme: Theme) -> Theme {
        currentTheme = theme
        return currentTheme
    }
}
