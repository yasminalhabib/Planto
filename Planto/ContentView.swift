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
            VStack(spacing: 29) {
                // Plant image (matches your asset name)
                Image("planto")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 164, height: 200)
                    .accessibilityLabel("Planto plant illustration")

                // Title and description
                VStack(spacing: 20) {
                    Text("Start your plant journey!")
                        .font(.title2)
                        .bold()

                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }

                // Push the button lower
                Spacer(minLength: 60)

                // Button to open the pop-up (no glassy effect)
                Button {
                    showSetReminder = true
                } label: {
                    Text("Set Plant Reminder")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 280, height: 44) // fixed size
                        .background(Color("green").opacity(0.9)) // solid color from Assets
                        .clipShape(Capsule())
                        .shadow(color: Color("green").opacity(0.3), radius: 6, y: 3)
                }

                Spacer()
            }
            .padding(.top, 16)
            .navigationTitle("My Plants 🌱")
        }
        // Presents the pop-up sheet
        .sheet(isPresented: $showSetReminder) {
            SetReminderView()
        }
    }
}

#Preview("ContentView – Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}



