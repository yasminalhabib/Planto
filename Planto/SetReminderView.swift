//
//  SetReminderView.swift
//  Planto
//
//  Created by Yasmin Alhabib on 19/10/2025.
//
import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full Sun"
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20–50 ml"

    var body: some View {
        NavigationStack {
            Form {
                Section { TextField("Plant Name", text: $plantName) }

                Section("Room") {
                    Picker("Room", selection: $room) {
                        Text("Bedroom").tag("Bedroom")
                        Text("Living Room").tag("Living Room")
                        Text("Kitchen").tag("Kitchen")
                        Text("Balcony").tag("Balcony")
                        Text("Bathroom").tag("Bathroom")
                    }
                }

                Section("Light") {
                    Picker("Light", selection: $light) {
                        Text("Full Sun").tag("Full Sun")
                        Text("Partial Sun").tag("Partial Sun")
                        Text("Low Light").tag("Low Light")
                    }
                }

                Section("Watering Days") {
                    Picker("Frequency", selection: $wateringDays) {
                        Text("Every day").tag("Every day")
                        Text("Every 2 days").tag("Every 2 days")
                        Text("Every 3 days").tag("Every 3 days")
                        Text("Once a week").tag("Once a week")
                        Text("Every 10 days").tag("Every 10 days")
                        Text("Every 2 weeks").tag("Every 2 weeks")
                    }
                }

                Section("Water") {
                    Picker("Amount", selection: $waterAmount) {
                        Text("20–50 ml").tag("20–50 ml")
                        Text("50–100 ml").tag("50–100 ml")
                        Text("100–200 ml").tag("100–200 ml")
                        Text("200–300 ml").tag("200–300 ml")
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: { Image(systemName: "xmark.circle.fill") }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                    }
                }
            }
        }
    }
}

