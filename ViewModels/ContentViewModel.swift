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
    @Published var showSetReminder = false           // used by the landing screen
    @Published var showAddSheet = false              // used by ListRemindersView (+) button
    @Published var reminders: [PlantReminder] = []
    @Published var completed: Set<UUID> = []         // track completed reminder IDs
    @Published var navigateToList: Bool = false      // drives navigation from landing to list
    
    // Optional dark-mode override (kept, but no UI here so layout matches the mock)
    @AppStorage("useCustomAppearance") var useCustomAppearance: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    // Header line shown above the progress bar
    var headerLine: String {
        let total = reminders.count
        let done = reminders.filter { completed.contains($0.id) }.count
        if total == 0 { return "No reminders yet" }
        return "\(done) of \(total) completed"
    }
    
    // Linear progress 0...1
    var progress: Double {
        let total = reminders.count
        guard total > 0 else { return 0 }
        let done = reminders.filter { completed.contains($0.id) }.count
        return Double(done) / Double(total)
    }
    
    func addReminder(_ reminder: PlantReminder) {
        reminders.append(reminder)
        
        // Dismiss any open sheets
        showSetReminder = false
        showAddSheet = false
        
        // Navigate to the list view
        navigateToList = true
    }
    
    func toggleCompleted(_ id: UUID) {
        if completed.contains(id) {
            completed.remove(id)
        } else {
            completed.insert(id)
        }
    }
}
