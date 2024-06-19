//
//  EditEventView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EditEventView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var event: VEvent

    @State private var name: String
    @State private var comment: String

    @State private var recordedDate: Date
    @State private var recordedMileage: Double?

    @State private var upcomingDate: Date = .now
    @State private var upcomingMileage: Double?

    @State private var isUsingUpcomingDate: Bool
    @State private var isCompleted: Bool

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Section("Comment") {
                    TextEditor(text: $comment)
                }

                Section("Recorded") {
                    DatePicker(
                        selection: $recordedDate,
                        displayedComponents: .date
                    ) {
                        Text("Date")
                    }

                    TextField("Mileage", value: $recordedMileage, format: .number)
                        .keyboardType(.numberPad)
                }

                Section("Next Occurrence") {
                    Toggle("Use upcoming date?", isOn: $isUsingUpcomingDate.animation())
                    if isUsingUpcomingDate {
                        DatePicker(
                            selection: $upcomingDate,
                            displayedComponents: .date
                        ) {
                            Text("Date")
                        }
                    }

                    TextField("Mileage", value: $upcomingMileage, format: .number)
                        .keyboardType(.numberPad)
                }

                Section {
                    Toggle("Is completed?", isOn: $isCompleted.animation())
                } header: {
                    Text("Tracking")
                } footer: {
                    Text("Marking event as completed will use current date and Vehicle's mileage as input values.")
                }
            }
            .navigationTitle("Edit Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Update") {
                        updateEvent()
                        dismiss()
                    }
                    .padding(.horizontal, 10)
                    .disabled(
                        name.isEmpty
                    )
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }

    init(event: VEvent) {
        self.event = event
        name = event.name
        comment = event.comment ?? ""

        recordedDate = event.recordedDate
        recordedMileage = event.recordedMileage

        upcomingDate = event.upcomingDate ?? .now
        upcomingMileage = event.upcomingMileage

        isUsingUpcomingDate = event.upcomingDate != nil
        isCompleted = event.isCompleted
    }

    private func updateEvent() {
        event.name = name
        event.comment = comment

        event.recordedDate = recordedDate
        event.recordedMileage = recordedMileage

        event.upcomingDate = isUsingUpcomingDate ? upcomingDate : nil
        event.upcomingMileage = upcomingMileage

        event.isCompleted = isCompleted

        if isCompleted {
            event.completedDate = .now
            event.completedMileage = event.vehicle?.mileage
        } else {
            event.completedDate = nil
            event.completedMileage = nil
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(
            brand: "Subaru",
            model: "Outback",
            comment: "hello",
            mileage: 12345,
            id: UUID().uuidString
        )
        container.mainContext.insert(vehicle)

        let event = VEvent(
            name: "Test Event",
            comment: """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""",
            recordedDate: Date.now,
            upcomingDate: Date.distantFuture,
            recordedMileage: 10_000,
            upcomingMileage: 20_000,
            id: UUID().uuidString
        )
        vehicle.events = [event]
        return EditEventView(event: event)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
