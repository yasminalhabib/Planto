//
//  EditPlantView.swift
//  Planto
//
//  Created by Yasmin Alhabib on 24/10/2025.
//
import SwiftUI

struct EditPlantView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ContentViewModel
    
    let plantToEdit: PlantReminder
    
    @State private var plantName: String = ""
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20–50 ml"
    @State private var showDeleteAlert = false
    
    let roomOptions = ["Bedroom", "Living Room", "Balcony"]
    let lightOptions = ["Full sun", "Partial shade", "Low light"]
    let daysOptions = ["Every day", "Every 2 days", "Weekly"]
    let waterOptions = ["20–50 ml", "50–100 ml", "100–150 ml"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Form {
                    Section {
                        TextField("Plant Name", text: $plantName)
                    }
                    
                    // 👉 REMOVED header: Text("Room & Light")
                    Section {
                        // 👉 ADDED icon
                        HStack {
                            Image(systemName: "paperplane")
                            Picker("Room", selection: $room) {
                                ForEach(roomOptions, id: \.self) { Text($0) }
                            }
                        }
                        
                        // 👉 ADDED icon
                        HStack {
                            Image(systemName: "sun.max")
                            Picker("Light", selection: $light) {
                                ForEach(lightOptions, id: \.self) { Text($0) }
                            }
                        }
                    }
                    
                    // 👉 REMOVED header: Text("Watering")
                    Section {
                        // 👉 ADDED icon
                        HStack {
                            Image(systemName: "drop")
                            Picker("Watering Days", selection: $wateringDays) {
                                ForEach(daysOptions, id: \.self) { Text($0) }
                            }
                        }
                        
                        // 👉 ADDED icon, CHANGED "Water Amount" to "Water"
                        HStack {
                            Image(systemName: "drop")
                            Picker("Water", selection: $waterAmount) {
                                ForEach(waterOptions, id: \.self) { Text($0) }
                            }
                        }
                    }
                }
                
                // DELETE BUTTON - unchanged
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Text("Delete Reminder")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .padding(.top, 8)
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveChanges()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("greeny").opacity(0.65))
                }
            }
            .alert("Delete Plant", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deletePlant()
                }
            } message: {
                Text("Are you sure you want to delete \(plantName)?")
            }
            .onAppear {
                loadPlantData()
            }
        }
    }
    
    private func loadPlantData() {
        plantName = plantToEdit.plantName
        room = plantToEdit.room
        light = plantToEdit.light
        wateringDays = plantToEdit.wateringDays
        waterAmount = plantToEdit.waterAmount
    }
    
    private func saveChanges() {
        vm.updateReminder(
            id: plantToEdit.id,
            plantName: plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                ? "Unnamed Plant" : plantName,
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )
        dismiss()
    }
    
    private func deletePlant() {
        vm.deleteReminder(plantToEdit.id)
        dismiss()
    }
}

#Preview {
    let plant = PlantReminder(
        plantName: "Pothos",
        room: "Bedroom",
        light: "Full sun",
        wateringDays: "Every day",
        waterAmount: "20–50 ml"
    )
    
    return EditPlantView(plantToEdit: plant)
        .environmentObject(ContentViewModel())
}
