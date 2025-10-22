//
//  ContentViewModel.swift
//  Planto
//
//  Created by Yasmin Alhabib on 22/10/2025.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    // UI state
    @Published var showSetReminder = false
    @Published var reminders: [PlantReminder] = []
    
    // Optional dark-mode override (kept, but no UI here so layout matches the mock)
    @AppStorage("useCustomAppearance") var useCustomAppearance: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    func addReminder(_ reminder: PlantReminder) {
        reminders.append(reminder)
    }
}
