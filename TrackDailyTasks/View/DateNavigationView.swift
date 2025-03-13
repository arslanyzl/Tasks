//
//  DateNavigationView.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

struct DateNavigationView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack {
            Button(action: {
                appState.moveToPreviousDay()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                Text(formattedDate)
                    .font(.headline)
                
                Button(action: {
                    appState.moveToToday()
                }) {
                    Text("Today")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(appState.theme.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .opacity(isToday ? 0 : 1)
            }
            
            Spacer()
            
            Button(action: {
                appState.moveToNextDay()
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: appState.currentDate)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(appState.currentDate)
    }
}

// MARK: - Preview Provider
struct DateNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Today preview
            DateNavigationView()
                .environmentObject(createMockAppState(for: Date()))
                .previewDisplayName("Today")
                .frame(height: 100)
        }
        .previewLayout(.sizeThatFits)
    }
    
    // Helper function to create mock AppState with specific date and theme
    static func createMockAppState(for date: Date) -> AppState {
        let mockRepo = MockTaskRepository()
        let mockTaskUseCase = MockTaskUseCase(repository: mockRepo)
        
        // Create a date navigation use case that returns our specific date
        let mockDateUseCase = MockDateNavigationUseCase()
        mockDateUseCase.setMockCurrentDate(date)
        
        // Create a theme use case with our settings
        let mockThemeUseCase = MockThemeUseCase()
        
        // Create and return the AppState
        return AppState(
            taskUseCase: mockTaskUseCase,
            dateNavigationUseCase: mockDateUseCase,
            themeUseCase: mockThemeUseCase
        )
    }
}
