//
//  SetReminderViewModel.swift
//  Planto
//
//  Created by Yasmin Alhabib on 22/10/2025.
//

import SwiftUI
import Combine

// ViewModels/SetReminderViewModel.swift
final class SetReminderViewModel: ObservableObject {
    @Published var plantName: String = ""
    @Published var room: String = "Bedroom"
    @Published var light: String = "Full sun"     // note lowercase “sun” if you want the exact label
    @Published var wateringDays: String = "Every day"
    @Published var waterAmount: String = "20–50 ml"

    func buildReminder() -> PlantReminder {
        PlantReminder(
            plantName: plantName.isEmpty ? "Unnamed Plant" : plantName,
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )
    }
}


