//
//  SetReminderView.swift
//  Planto
//
//  Created by Yasmin Alhabib on 19/10/2025.
//
import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SetReminderViewModel

    /// Called when user taps Save (✓)
    var onSave: (PlantReminder) -> Void

    // Options
    private let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    private let lights = ["Full Sun", "Partial Sun", "Low Light"]
    private let days = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    private let waters = ["20–50 ml", "50–100 ml", "100–200 ml", "200–300 ml"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    // Big rounded TextField pill
                    RoundedCard {
                        HStack(spacing: 12) {
                            // Fixed label inside the pill (white text)
                            Text("Plant Name")
                                .font(.body)
                                .foregroundStyle(.white)

                            // Green separator line between label and input
                            Rectangle()
                                .fill(Color("greeny"))
                                .frame(width: 3, height: 22)
                                .cornerRadius(1.5)

                            // Editable text box for the user's input
                            TextField("", text: $viewModel.plantName, prompt: Text("Pothos").foregroundStyle(.secondary))
                                .textInputAutocapitalization(.words)
                                .disableAutocorrection(true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 6)
                        .frame(minHeight: 56)
                    }

                    // Room + Light
                    RoundedCard {
                        VStack(spacing: 0) {
                            SettingRow(
                                icon: "paperplane",
                                title: "Room",
                                trailing: { MenuPicker(selection: $viewModel.room, options: rooms) }
                            )
                            Divider().overlay(.white.opacity(0.12))
                            SettingRow(
                                icon: "sun.max",
                                title: "Light",
                                trailing: { MenuPicker(selection: $viewModel.light, options: lights) }
                            )
                        }
                    }

                    // Watering Days + Water Amount
                    RoundedCard {
                        VStack(spacing: 0) {
                            SettingRow(
                                icon: "drop",
                                title: "Watering Days",
                                trailing: { MenuPicker(selection: $viewModel.wateringDays, options: days) }
                            )
                            Divider().overlay(.white.opacity(0.12))
                            SettingRow(
                                icon: "drop.fill",
                                title: "Water",
                                trailing: { MenuPicker(selection: $viewModel.waterAmount, options: waters) }
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .navigationTitle("Set Reminder")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CircularToolbarButton(systemName: "xmark") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    CircularToolbarButton(systemName: "checkmark", tint: Color("AppGreen")) {
                        onSave(viewModel.buildReminder())
                        dismiss()
                    }
                }
            }
            .tint(Color("AppGreen"))
            .background(Color(.systemBackground))
        }
    }
}

// MARK: - Reusable Pieces

private struct RoundedCard<Content: View>: View {
    @Environment(\.colorScheme) private var scheme
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(scheme == .dark
                          ? Color.white.opacity(0.06)
                          : Color.black.opacity(0.04))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.white.opacity(scheme == .dark ? 0.10 : 0.06), lineWidth: 1)
            )
    }
}

private struct SettingRow<Trailing: View>: View {
    let icon: String
    let title: String
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 30, height: 30)
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .opacity(0.9)
            }

            Text(title)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
        .frame(minHeight: 54)
        .contentShape(Rectangle())
    }
}

private struct MenuPicker: View {
    @Binding var selection: String
    let options: [String]

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { value in
                Button {
                    selection = value
                } label: {
                    HStack {
                        Text(value)
                        if value == selection { Image(systemName: "checkmark") }
                    }
                }
            }
        } label: {
            HStack(spacing: 6) {
                Text(selection)
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Capsule().fill(.ultraThinMaterial))
        }
    }
}

private struct CircularToolbarButton: View {
    let systemName: String
    var tint: Color? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(tint ?? .primary)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(radius: 2, y: 1)
        }
    }
}

#Preview("SetReminderView – Dark") {
    NavigationStack {
        SetReminderView(viewModel: SetReminderViewModel()) { _ in }
    }
    .preferredColorScheme(.dark)
}

#Preview("SetReminderView – Light") {
    NavigationStack {
        SetReminderView(viewModel: SetReminderViewModel()) { _ in }
    }
    .preferredColorScheme(.light)
}
