//
//  SetReminderViewModel.swift
//  Planto
//
//  Created by Yasmin Alhabib on 22/10/2025.
//

import SwiftUI
import Combine

final class SetReminderViewModel: ObservableObject {
    @Published var plantName: String = ""
    @Published var room: String = "Bedroom"
    @Published var light: String = "Full Sun"
    @Published var wateringDays: String = "Every day"
    @Published var waterAmount: String = "20–50 ml"

    // Enable the check button only when valid
    var canSave: Bool {
        !plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func buildReminder() -> PlantReminder {
        PlantReminder(
            plantName: plantName.trimmingCharacters(in: .whitespacesAndNewlines),
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )
    }
}

