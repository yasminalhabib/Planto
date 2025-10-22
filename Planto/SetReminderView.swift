import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ContentViewModel   // <-- hook into your view model

    // form state
    @State private var plantName: String = ""
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20–50 ml"

    // options
    private let roomOptions  = ["Bedroom", "Living Room", "Balcony"]
    private let lightOptions = ["Full sun", "Partial shade", "Low light"]
    private let daysOptions  = ["Every day", "Every 2 days", "Weekly"]
    private let waterOptions = ["20–50 ml", "50–100 ml", "100–150 ml"]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Plant Name", text: $plantName)
                }

                Section(header: Text("Room & Light")) {
                    Picker("Room", selection: $room) {
                        ForEach(roomOptions, id: \.self) { Text($0) }
                    }

                    Picker("Light", selection: $light) {
                        ForEach(lightOptions, id: \.self) { Text($0) }
                    }
                }

                Section(header: Text("Watering")) {
                    Picker("Watering Days", selection: $wateringDays) {
                        ForEach(daysOptions, id: \.self) { Text($0) }
                    }

                    Picker("Water Amount", selection: $waterAmount) {
                        ForEach(waterOptions, id: \.self) { Text($0) }
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button { saveReminder() } label: {
                        Image(systemName: "checkmark").foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("greeny").opacity(0.65))   // uses your asset named “greeny”
                }
            }
        }
    }

    private func saveReminder() {
        // Build the model and ADD it to the VM
        let reminder = PlantReminder(
            plantName: plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                ? "Unnamed Plant" : plantName,
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )
        vm.addReminder(reminder)
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    SetReminderView()
        .environmentObject(ContentViewModel())   // required for preview
}
