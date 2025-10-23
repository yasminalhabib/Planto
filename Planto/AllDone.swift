//
//  AllDone.swift
//  Planto
//
//  Created by Yasmin Alhabib on 23/10/2025.
//
import SwiftUI

/// Full-screen "All reminders completed" screen
struct AllRemindersCompletedView: View {
    var onAddTapped: (() -> Void)? = nil   // optional callback for the + button

    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                ScrollView {
                    VStack(spacing: 24) {
                        // Thin divider under the large title (to match your mock)
                        Divider()
                            .opacity(0.25)
                            .padding(.horizontal, 20)
                            .padding(.top, 4)

                        // Big illustration + texts centered
                        Spacer(minLength: 32)

                        VStack(spacing: 28) {
                            // Circular backdrop + plant image
                            ZStack {
                                Circle()
                                    .fill(Color.primary.opacity(0.08))
                                    .frame(width: 280, height: 280)

                                Image("planty")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 240, height: 240)
                            }

                            VStack(spacing: 10) {
                                Text("All Done! 🎉")
                                    .font(.system(size: 34, weight: .bold))

                                Text("All Reminders Completed")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                            }
                            .multilineTextAlignment(.center)
                        }

                        Spacer(minLength: 120)
                    }
                    .frame(maxWidth: .infinity)
                }

                // Floating (+) button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingAddButton {
                            onAddTapped?()
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("My Plants 🌱")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

/// Reusable floating add button (uses asset color "greeny")
private struct FloatingAddButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color("greeny"))
                .clipShape(Circle())
                .shadow(color: Color("greeny").opacity(0.45), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview("All Reminders Completed – Dark") {
    AllRemindersCompletedView()
        .preferredColorScheme(.dark)
}

#Preview("All Reminders Completed – Light") {
    AllRemindersCompletedView()
        .preferredColorScheme(.light)
}

