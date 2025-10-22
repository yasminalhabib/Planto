//
//  ContentView.swift
//  Planto
//
//  Created by Yasmin Alhabib on 17/10/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Header (matches screenshot)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("My Plants 🌱")
                            .font(.system(size: 44, weight: .bold, design: .default))
                            .kerning(-0.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .overlay(Color.primary.opacity(0.25))
                    }
                    .padding(.top, 8)
                    
                    // MARK: Illustration
                    Image("planto")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 260)
                        .accessibilityLabel("Planto plant illustration")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                        .padding(.horizontal, 12)
                    
                    // MARK: Headline + Subhead
                    VStack(spacing: 16) {
                        Text("Start your plant journey!")
                            .font(.system(size: 25, weight: .heavy))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.system(size: 18))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 560)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity)
                    
                    // Push button a bit higher while keeping center alignment
                    Spacer(minLength: 80)
                    
                    // Mark: Button (exact Sketch size 280 x 44)
                    Button {
                        vm.showSetReminder = true
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 280, height: 44)
                            .contentShape(Capsule())
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(GreenCapsuleButtonStyle())
                    
                    // Bottom breathing room
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .navigationBarTitleDisplayMode(.inline) // we use custom header; keep nav bar slim
            .toolbar { /* no buttons here to keep the mock exact */ }
        }
        // Only force scheme if user opted to override (optional dark mode)
        .preferredColorScheme(vm.useCustomAppearance ? (vm.isDarkMode ? .dark : .light) : nil)
        .sheet(isPresented: $vm.showSetReminder) {
            SetReminderView(viewModel: SetReminderViewModel()) { newReminder in
                vm.addReminder(newReminder)
            }
        }
    }
}

// MARK: - Button Style (uses asset color "green")
private struct GreenCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.black.opacity(0.9))
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color("greeny"),
                                Color("greeny").opacity(0.85)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
            )
            .shadow(color: Color("greeny").opacity(0.35), radius: 10, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview("ContentView – Dark mock") {
    ContentView()
        .environment(\.colorScheme, .dark)
}

#Preview("ContentView – Light") {
    ContentView()
        .environment(\.colorScheme, .light)
}
