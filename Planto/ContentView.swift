import SwiftUI

struct ContentView: View {
    @StateObject private var vm: ContentViewModel

    init(vm: ContentViewModel = ContentViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Divider()
                        .opacity(0.25)
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                    
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
                    
                    Spacer(minLength: 80)
                    
                    // MARK: Button
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
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .navigationTitle("My Plants 🌱")
            .navigationBarTitleDisplayMode(.large)
            // 👉 THIS IS KEY: Navigation happens INSIDE NavigationStack
            .navigationDestination(isPresented: $vm.navigateToList) {
                ListRemindersView(vm: vm)
            }
        }
        .preferredColorScheme(vm.useCustomAppearance ? (vm.isDarkMode ? .dark : .light) : nil)
        // 👉 Sheet is OUTSIDE NavigationStack but still works
        .sheet(isPresented: $vm.showSetReminder) {
            SetReminderView()
                .environmentObject(vm)
        }
    }
}

#Preview {
    ContentView()
}
