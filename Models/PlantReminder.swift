//
//  PlantReminder.swift
//  Planto
//
//  Created by Yasmin Alhabib on 22/10/2025.
//

import Foundation

struct PlantReminder: Identifiable, Equatable {
    let id = UUID()
    var plantName: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
}
