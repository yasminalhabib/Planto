# Planto app

Planto is A simple and elegant iOS app built with SwiftUI, helping users keep track of their plants — where they are, how much light they need, and when to water them.

##Features

-Add new plant reminders with name, room, light preference, and watering schedule.
-Edit plants or swipe to delete.
-“All done” screen when every plant is watered.
-Notifications.

##Architecture

This project follows the MVVM (Model–View–ViewModel) pattern:
Model: PlantReminder — holds plant data
ViewModel: ContentViewModel — handles logic and data updates
Views (Planto): ListRemindersView, SetReminderView, EditPlantView, and so on.
