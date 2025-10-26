import SwiftUI

/// Today list screen: shows reminders, progress, and a (+) add button
struct ListRemindersView: View {
    @ObservedObject var vm: ContentViewModel
    @State private var showAllDone = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Black background
                Color.black.ignoresSafeArea()
                
                // MAIN CONTENT
                VStack(spacing: 16) {
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .padding(.horizontal, 20)

                    // Status message + progress bar
                    VStack(spacing: 12) {
                        // 👉 FIX: Access the property directly
                        Text(statusText)
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        ProgressView(value: vm.progress, total: 1.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("greeny")))
                            .scaleEffect(y: 2)
                            .frame(height: 4)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 8)

                    // Reminders list
                    List {
                        ForEach(vm.reminders) { item in
                            ReminderRow(
                                item: item,
                                checked: vm.completed.contains(item.id),
                                onToggle: { vm.toggleCompleted(item.id) }
                            )
                            .contentShape(Rectangle())
                            .onTapGesture { vm.plantToEdit = item }
                            .listRowBackground(Color.black)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowSeparator(.visible, edges: .bottom)
                            .listRowSeparatorTint(Color.white.opacity(0.1))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    vm.deleteReminder(item.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                }

                // FLOATING (+) BUTTON OVERLAY
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { vm.showAddSheet = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 60, height: 60)
                                .background(Color("greeny"))
                                .clipShape(Circle())
                                .shadow(color: Color("greeny").opacity(0.4), radius: 12, y: 6)
                        }
                        .padding(20)
                    }
                }
            }
            .navigationTitle("My Plants 🌱")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $vm.showAddSheet) {
            SetReminderView()
                .environmentObject(vm)
        }
        .sheet(item: $vm.plantToEdit) { plant in
            EditPlantView(plantToEdit: plant)
                .environmentObject(vm)
        }
        .onAppear { updateAllDoneFlag() }
        .onChange(of: vm.progress) { _ in updateAllDoneFlag(withHaptics: false) }
        .onChange(of: vm.completed) { _ in updateAllDoneFlag(withHaptics: true) }
        .fullScreenCover(isPresented: $showAllDone) {
            AllRemindersCompletedView(onAddTapped: {
                showAllDone = false
                vm.showAddSheet = true
            })
        }
    }

    // 👉 FIX: Create computed property in the View
    private var statusText: String {
        let total = vm.reminders.count
        let done = vm.completed.count
        
        if total == 0 {
            return "Your plants are waiting for a sip 💧"
        } else if done == total {
            return "\(total) of your plants feel loved today ✨"
        } else if done == 0 {
            return "Your plants are waiting for a sip 💧"
        } else {
            return "\(done) of your plants feel loved today ✨"
        }
    }

    // MARK: - Helpers
    private func updateAllDoneFlag(withHaptics: Bool = false) {
        let allDone = !vm.reminders.isEmpty && vm.completed.count == vm.reminders.count
        withAnimation(.spring()) { showAllDone = allDone }
        if withHaptics && allDone {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }
}

// 👉 REMOVED FloatingAddButton struct - now inline in the ZStack

#Preview("Empty List") {
    let vm = ContentViewModel()
    return ListRemindersView(vm: vm)
}

#Preview("With Plants") {
    let vm = ContentViewModel()
    vm.reminders = [
        PlantReminder(plantName: "Monstera", room: "Kitchen", light: "Full sun", wateringDays: "Every day", waterAmount: "20–50 ml"),
        PlantReminder(plantName: "Pothos", room: "Bedroom", light: "Full sun", wateringDays: "Every day", waterAmount: "20–50 ml"),
        PlantReminder(plantName: "Orchid", room: "Living Room", light: "Full sun", wateringDays: "Every day", waterAmount: "20–50 ml"),
        PlantReminder(plantName: "Spider", room: "Kitchen", light: "Full sun", wateringDays: "Every day", waterAmount: "20–50 ml")
    ]
    vm.completed.insert(vm.reminders[1].id)
    vm.completed.insert(vm.reminders[2].id)
    vm.completed.insert(vm.reminders[3].id)
    return ListRemindersView(vm: vm)
}


//import SwiftUI
//
///// Today list screen: shows reminders, progress, and a (+) add button
//struct ListRemindersView: View {
//    @ObservedObject var vm: ContentViewModel
//    @State private var showAllDone = false
//
//    var body: some View {
//        NavigationStack {
//            RootContent(
//                mainContent: AnyView(mainContent),
//                floatingOverlay: AnyView(floatingAddButtonOverlay)
//            )
//            .navigationTitle("My Plants 🌱")
//            .navigationBarTitleDisplayMode(.large)
//        }
//        .applyPresentationAndReactions(
//            vm: vm,
//            showAllDone: $showAllDone
//        )
//    }
//
//    // MARK: - Subviews
//
//    private var mainContent: some View {
//        VStack(spacing: 16) {
//            Divider()
//                .opacity(0.25)
//                .padding(.horizontal, 20)
//
//            HeaderProgressView(
//                headerLine: vm.headerLine,
//                progress: vm.progress
//            )
//            .padding(.horizontal, 20)
//
//            RemindersListView(
//                reminders: vm.reminders,
//                completed: vm.completed,
//                onToggle: { (id: UUID) in vm.toggleCompleted(id) },
//                onDelete: { (id: UUID) in vm.deleteReminder(id) },
//                onTap: { (plant: PlantReminder) in vm.plantToEdit = plant }
//            )
//        }
//    }
//
//    private var floatingAddButtonOverlay: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                FloatingAddButton {
//                    vm.showAddSheet = true
//                }
//                .padding(20)
//            }
//        }
//    }
//}
//
//// A tiny wrapper to reduce complexity in ListRemindersView.body
//private struct RootContent: View {
//    let mainContent: AnyView
//    let floatingOverlay: AnyView
//
//    var body: some View {
//        ZStack {
//            mainContent
//            floatingOverlay
//        }
//    }
//}
//
//private struct HeaderProgressView: View {
//    let headerLine: String
//    let progress: Double
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(headerLine)
//                .font(.callout)
//                .foregroundStyle(.secondary)
//
//            ProgressView(value: progress, total: 1.0)
//                .progressViewStyle(.linear)
//                .tint(Color("greeny"))
//        }
//    }
//}
//
//private struct RemindersListView: View {
//    let reminders: [PlantReminder]
//    let completed: Set<UUID>
//    let onToggle: (UUID) -> Void
//    let onDelete: (UUID) -> Void
//    let onTap: (PlantReminder) -> Void
//
//    var body: some View {
//        List {
//            ForEach(reminders) { item in
//                ReminderRowContainer(
//                    item: item,
//                    checked: completed.contains(item.id),
//                    onToggle: { onToggle(item.id) },
//                    onDelete: { onDelete(item.id) },
//                    onTap: { onTap(item) }
//                )
//            }
//        }
//        .listStyle(.plain)
//        .scrollContentBackground(.hidden)
//    }
//}
//
//// Extract the row + swipeActions to cut down inference inside ForEach
//private struct ReminderRowContainer: View {
//    let item: PlantReminder
//    let checked: Bool
//    let onToggle: () -> Void
//    let onDelete: () -> Void
//    let onTap: () -> Void
//
//    var body: some View {
//        ReminderRow(
//            item: item,
//            checked: checked,
//            onToggle: onToggle
//        )
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//        .listRowBackground(Color(uiColor: .secondarySystemBackground))
//        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//            DeleteSwipeAction(onDelete: onDelete)
//        }
//    }
//}
//
//private struct DeleteSwipeAction: View {
//    let onDelete: () -> Void
//    var body: some View {
//        Button(role: .destructive, action: onDelete) {
//            Label("Delete", systemImage: "trash")
//        }
//    }
//}
//
//// MARK: - Modifiers extracted to reduce body complexity
//
//private extension View {
//    func applyPresentationAndReactions(
//        vm: ContentViewModel,
//        showAllDone: Binding<Bool>
//    ) -> some View {
//        modifier(PresentationAndReactionsModifier(vm: vm, showAllDone: showAllDone))
//    }
//}
//
//private struct PresentationAndReactionsModifier: ViewModifier {
//    @ObservedObject var vm: ContentViewModel
//    @Binding var showAllDone: Bool
//
//    func body(content: Content) -> some View {
//        content
//            // Add sheet
//            .sheet(isPresented: $vm.showAddSheet) {
//                SetReminderView()
//                    .environmentObject(vm)
//            }
//            // EDIT sheet — now uses a tiny helper to keep the compiler happy
//            .sheet(item: $vm.plantToEdit) { plant in
//                EditSheetView(plant: plant, vm: vm)
//            }
//            // "All Done" presentation logic
//            .onAppear {
//                showAllDone = vm.progress == 1.0 && !vm.reminders.isEmpty
//            }
//            .onChange(of: vm.progress) { newValue in
//                showAllDone = (newValue == 1.0 && !vm.reminders.isEmpty)
//            }
//            .onChange(of: vm.completed) { completed in
//                let allDone = !vm.reminders.isEmpty && completed.count == vm.reminders.count
//                withAnimation(.spring()) {
//                    showAllDone = allDone
//                }
//                if allDone {
//                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//                }
//            }
//            .onChange(of: vm.reminders) { _ in
//                let allDone = !vm.reminders.isEmpty && vm.completed.count == vm.reminders.count
//                showAllDone = allDone
//            }
//            .fullScreenCover(isPresented: $showAllDone) {
//                AllRemindersCompletedView(onAddTapped: {
//                    showAllDone = false
//                    vm.showAddSheet = true
//                })
//            }
//    }
//}
//
//// MARK: - Tiny helper used by the edit sheet
//
//private struct EditSheetView: View {
//    let plant: PlantReminder
//    @ObservedObject var vm: ContentViewModel
//
//    var body: some View {
//        EditPlantView(plantToEdit: plant)
//            .environmentObject(vm)
//    }
//}
//
