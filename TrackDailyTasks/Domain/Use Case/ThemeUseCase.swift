//
//  ThemeUseCase.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class ThemeUseCase: ThemeUseCaseProtocol {
    private let userDefaults = UserDefaults.standard
    private let themeKey = "app_theme"
    
    func getCurrentTheme() -> Theme {
        if let data = userDefaults.data(forKey: themeKey),
           let theme = try? JSONDecoder().decode(Theme.self, from: data) {
            return theme
        }
        return Theme()
    }
    
    func toggleTheme() -> Theme {
        var theme = getCurrentTheme()
        theme.isDarkMode.toggle()
        saveTheme(theme)
        return theme
    }
    
    func setTheme(_ theme: Theme) -> Theme {
        saveTheme(theme)
        return theme
    }
    
    private func saveTheme(_ theme: Theme) {
        if let encoded = try? JSONEncoder().encode(theme) {
            userDefaults.set(encoded, forKey: themeKey)
        }
    }
}
