//
//  ReminderRow.swift
//  Planto
//
//  Created by Assistant on 26/10/2025.
//

import SwiftUI

struct ReminderRow: View {
    let item: PlantReminder
    let checked: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Check circle
            Button(action: onToggle) {
                Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(checked ? Color("greeny") : .secondary)
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .padding(.leading, 16)
            .padding(.vertical, 12)

            // Plant info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.plantName)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .strikethrough(checked, color: .secondary)

                HStack(spacing: 8) {
                    Label(item.room, systemImage: "house")
                    Label(item.light, systemImage: "sun.max")
                    Label(item.wateringDays, systemImage: "calendar")
                    Label(item.waterAmount, systemImage: "drop")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            }
            .padding(.vertical, 12)

            Spacer(minLength: 8)
        }
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    ReminderRow(
        item: PlantReminder(
            plantName: "Snake Plant",
            room: "Bedroom",
            light: "Full sun",
            wateringDays: "Every day",
            waterAmount: "20–50 ml"
        ),
        checked: false,
        onToggle: {}
    )
    .previewLayout(.sizeThatFits)
    .padding()
    .background(Color(.systemBackground))
}

