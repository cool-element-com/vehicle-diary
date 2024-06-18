//
//  CreateEventView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct CreateEventView: View {
    @Environment(\.dismiss) var dismiss

    @Bindable var vehicle: Vehicle
    @State private var name: String = ""
    @State private var comment: String?

    @State private var recordedDate: Date = .now
    @State private var recordedMileage: Double?

    @State private var upcomingDate: Date = .now
    @State private var upcomingMileage: Double?
    @State private var isUsingNextDate = false

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Section("Comment") {
                    TextEditor(text: Binding(
                        get: {
                            comment ?? ""
                        },
                        set: { value in
                            comment = value
                        }))
                }

                Section("Current Event") {
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
                    Toggle("Use upcoming date?", isOn: $isUsingNextDate.animation())
                    if isUsingNextDate {
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
            }
            .navigationTitle("Create Event")
            .navigationBarTitleDisplayMode(.inline)

            Button("Create") {
                createEvent()
                dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .disabled(
                name.isEmpty
            )
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }

    private func createEvent() {
        let event = VEvent(
            name: name,
            comment: comment,
            recordedDate: recordedDate,
            upcomingDate: isUsingNextDate ? upcomingDate : nil,
            recordedMileage: recordedMileage,
            upcomingMileage: upcomingMileage
        )

        vehicle.events?.append(event)
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
        return
            CreateEventView(vehicle: vehicle)
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
