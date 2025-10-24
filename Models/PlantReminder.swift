//
//  PlantReminder.swift
//  Planto
//
//  Created by Yasmin Alhabib on 22/10/2025.
//

import Foundation

struct PlantReminder: Identifiable {
    let id: UUID
    var plantName: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    
    // 👉 Default initializer with new ID (for adding new plants)
    init(plantName: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        self.id = UUID()
        self.plantName = plantName
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
    }
    
    // 👉 Initializer that accepts existing ID (for updating plants)
    init(id: UUID, plantName: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        self.id = id
        self.plantName = plantName
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
    }
}
