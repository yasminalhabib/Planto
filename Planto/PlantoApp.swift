//
//  PlantoApp.swift
//  Planto
//
//  Created by Yasmin Alhabib on 17/10/2025.
//

import SwiftUI

@main
struct PlantoApp: App {
    
    init() {
        // 👉 Request notification permission when app launches
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView() // entry point
                .preferredColorScheme(.dark)
        }
    }
}
