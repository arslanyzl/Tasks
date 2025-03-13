//
//  AppTheme.swift
//  TaskManager
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI


struct Theme: Codable {
    var isDarkMode: Bool
    var accentColor: Color
    
    init(isDarkMode: Bool = false, accentColor: Color = .blue) {
        self.isDarkMode = isDarkMode
        self.accentColor = accentColor
    }
}
