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
        HStack(spacing: 16) {
            // Checkmark circle
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .strokeBorder(checked ? Color("greeny") : Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 28, height: 28)
                    
                    if checked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color("greeny"))
                    }
                }
            }
            .buttonStyle(.plain)
            
            // Plant info
            VStack(alignment: .leading, spacing: 8) {
                // Room label
                HStack(spacing: 6) {
                    Image(systemName: "paperplane")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("in \(item.room)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // Plant name - 👉 REMOVED strikethrough
                Text(item.plantName)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(checked ? .gray : .white)
                
                // Tags (light and water)
                HStack(spacing: 8) {
                    TagPill(icon: "sun.max", text: item.light)
                    TagPill(icon: "drop", text: item.waterAmount)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.black)
    }
}

// MARK: - Tag Pill
private struct TagPill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption2)
            Text(text)
                .font(.caption2)
        }
        .foregroundColor(.white.opacity(0.7))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview("Unchecked") {
    ReminderRow(
        item: PlantReminder(
            plantName: "Monstera",
            room: "Kitchen",
            light: "Full sun",
            wateringDays: "Every day",
            waterAmount: "20–50 ml"
        ),
        checked: false,
        onToggle: {}
    )
    .background(Color.black)
    .previewLayout(.sizeThatFits)
}

#Preview("Checked") {
    ReminderRow(
        item: PlantReminder(
            plantName: "Pothos",
            room: "Bedroom",
            light: "Full sun",
            wateringDays: "Every day",
            waterAmount: "20–50 ml"
        ),
        checked: true,
        onToggle: {}
    )
    .background(Color.black)
    .previewLayout(.sizeThatFits)
}

