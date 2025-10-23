
import SwiftUI

/// Today list screen: shows reminders, progress, and a (+) add button
struct ListRemindersView: View {
    @ObservedObject var vm: ContentViewModel
    @State private var showAllDone = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                VStack(spacing: 16) {
                    Divider().opacity(0.25)
                        .padding(.horizontal, 20)

                    // Status line + progress
                    VStack(alignment: .leading, spacing: 8) {
                        Text(vm.headerLine)
                            .font(.callout)
                            .foregroundStyle(.secondary)

                        ProgressView(value: vm.progress)
                            .progressViewStyle(.linear)
                            .tint(Color("greeny"))
                    }
                    .padding(.horizontal, 20)

                    // List
                    ScrollView {
                        LazyVStack(spacing: 1) {
                            ForEach(vm.reminders) { item in
                                ReminderRow(
                                    item: item,
                                    checked: vm.completed.contains(item.id),
                                    onToggle: { vm.toggleCompleted(item.id) }
                                )
                                .background(Color(.secondarySystemBackground))
                            }
                        }
                        .padding(.top, 8)
                    }
                }

                // Floating (+) button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingAddButton {
                            vm.showAddSheet = true
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("My Plants 🌱")
            .navigationBarTitleDisplayMode(.large)
        }
        // Present your SetReminderView and feed the result into the VM
        .sheet(isPresented: $vm.showAddSheet) {
            SetReminderView()
                .environmentObject(vm)
        }

        // Show the "All Done" page when progress hits 100%
        .onAppear {
            showAllDone = vm.progress == 1.0 && !vm.reminders.isEmpty
        }
        .onChange(of: vm.progress) { newValue in
            showAllDone = (newValue == 1.0 && !vm.reminders.isEmpty)
        }
        .fullScreenCover(isPresented: $showAllDone) {
            AllRemindersCompletedView(onAddTapped: {
                showAllDone = false
                vm.showAddSheet = true
            })
        }
    }
}

// MARK: - Row (single reminder)
private struct ReminderRow: View {
    let item: PlantReminder
    let checked: Bool
    let onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "paperplane")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("in \(item.room)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            HStack(alignment: .top, spacing: 12) {
                Button(action: onToggle) {
                    Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(checked ? Color("greeny") : .secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(item.plantName)
                        .font(.title3.weight(.semibold))
                    HStack(spacing: 8) {
                        TagPill(icon: "sun.max", text: item.light)
                        TagPill(icon: "drop", text: item.waterAmount)
                    }
                }

                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

// MARK: - Tag Pill
private struct TagPill: View {
    let icon: String
    let text: String
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.caption)
            Text(text).font(.caption)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(Capsule().fill(Color.primary.opacity(0.08)))
    }
}

// MARK: - Floating Button
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
    }
}

// MARK: - Previews

#Preview("List – Empty (Dark)") {
    let vm = ContentViewModel()              // no reminders
    return NavigationStack { ListRemindersView(vm: vm) }
        .preferredColorScheme(.dark)
}

