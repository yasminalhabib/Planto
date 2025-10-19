//
//  ContentView.swift
//  Planto
//
//  Created by Yasmin Alhabib on 17/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showSetReminder = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Plant image (matches your asset name)
                Image("planto")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .accessibilityLabel("Planto plant illustration")

                // Title and description
                VStack(spacing: 8) {
                    Text("Start your plant journey!")
                        .font(.title2)
                        .bold()

                    Text("Now all your plants will be in one place and we will help you take care of them 🙂🌿")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }

                // Button to open the pop-up
                Button {
                    showSetReminder = true
                } label: {
                    Text("Set Plant Reminder")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding(.horizontal, 32)
                }

                Spacer()
            }
            .padding(.top, 16)
            .navigationTitle("My Plants 🌿")
        }
        // Presents the pop-up sheet
        .sheet(isPresented: $showSetReminder) {
            SetReminderView()
        }
    }
}

