//
//  TrackDailyTasksTests.swift
//  TrackDailyTasksTests
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Testing
@testable import TrackDailyTasks
import Foundation

@Suite("UserDefaultsTaskRepository Tests")
struct UserDefaultsTaskRepositoryTests {
    let testTasksKey = "saved_tasks"
    
    // Sample tasks for testing
    let task1 = Task(id: UUID(), title: "Task 1", description: "Description 1", date: Date.now, isCompleted: false)
    let task2 = Task(id: UUID(), title: "Task 2", description: "Description 2", date: Date.now, isCompleted: true)
    let task3 = Task(id: UUID(), title: "Task 3", description: "Description 3", date: Date.now, isCompleted: false)
    
    func setup() {
        // Clear the user defaults before each test
        UserDefaults.standard.removeObject(forKey: testTasksKey)
    }
    
    func teardown() {
        // Clean up after each test
        UserDefaults.standard.removeObject(forKey: testTasksKey)
    }
    
    @Test("Get all tasks when empty returns empty array")
    func testGetAllTasksWhenEmpty() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        
        // When
        let tasks = repository.getAllTasks()
        
        // Then
        #expect(tasks.isEmpty)
    }
    
    @Test("Save task saves a single task correctly")
    func testSaveTaskSingleTask() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        let task = task1
        
        // When
        repository.saveTask(task)
        let savedTasks = repository.getAllTasks()
        
        // Then
        #expect(savedTasks.count == 1)
        #expect(savedTasks.first?.title == task.title)
    }
    
    @Test("Save multiple tasks saves all correctly")
    func testSaveMultipleTasks() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        let tasks = [task1, task2, task3]
        
        // When
        tasks.forEach { repository.saveTask($0) }
        let savedTasks = repository.getAllTasks()
        
        // Then
        #expect(savedTasks.count == 3)
        #expect(savedTasks.contains(where: { $0.id == task1.id }))
        #expect(savedTasks.contains(where: { $0.id == task2.id }))
        #expect(savedTasks.contains(where: { $0.id == task3.id }))
    }
    
    @Test("Update task updates an existing task correctly")
    func testUpdateExistingTask() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        repository.saveTask(task1)
        var updatedTask = task1
        updatedTask.title = "Updated Title"
        updatedTask.isCompleted = true
        
        // When
        repository.updateTask(updatedTask)
        let savedTasks = repository.getAllTasks()
        
        // Then
        #expect(savedTasks.count == 1)
        print(savedTasks)
        #expect(savedTasks.first!.title == "Updated Title")
        #expect(savedTasks.first!.isCompleted == true)
    }
    
    @Test("Update non-existing task does nothing")
    func testUpdateNonExistingTask() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        repository.saveTask(task1)
        let nonExistingTask = Task(id: UUID(), title: "Non-existing", description: "Should not be added", date: Date.now, isCompleted: false)
        
        // When
        repository.updateTask(nonExistingTask)
        let savedTasks = repository.getAllTasks()
        
        // Then
        #expect(savedTasks.count == 1)
        #expect(savedTasks.first!.id == task1.id)
    }
    
    @Test("Delete task removes an existing task correctly")
    func testDeleteExistingTask() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        repository.saveTask(task1)
        repository.saveTask(task2)
        
        // When
        repository.deleteTask(task1)
        let savedTasks = repository.getAllTasks()
        sleep(2)
        // Then
        #expect(savedTasks.count == 1)
        #expect(savedTasks.first!.id == task2.id)
    }
    
    @Test("Delete non-existing task does nothing")
    func testDeleteNonExistingTask() {
        setup()
        defer { teardown() }
        
        // Given
        let repository = UserDefaultsTaskRepository()
        repository.saveTask(task1)
        let nonExistingTask = Task(id: UUID(), title: "Non-existing", description: "Should not affect deletion", date: Date.now, isCompleted: false)
        
        // When
        repository.deleteTask(nonExistingTask)
        let savedTasks = repository.getAllTasks()
        
        // Then
        #expect(savedTasks.count == 1)
        #expect(savedTasks.first!.id == task1.id)
    }
    
    @Test("Get all tasks after encoding error returns empty array")
    func testGetAllTasksAfterEncodingError() {
        setup()
        defer { teardown() }
        
        // This test simulates an encoding error
        class MockRepository: UserDefaultsTaskRepository {
            func saveTasks(_ tasks: [Task]) {
                // Simulate an encoding error by not saving anything
            }
        }
        
        // Given
        let mockRepository = MockRepository()
        
        // When
        mockRepository.saveTask(task1)
        let tasks = mockRepository.getAllTasks()
        
        // Then
        sleep(1)
        #expect(tasks.isEmpty)
    }
}
