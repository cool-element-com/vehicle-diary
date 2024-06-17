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
    @Environment(\.modelContext) var modelContext

    @Bindable var vehicle: Vehicle
    @State private var name: String = ""
    @State private var comment: String?

    @State private var recordedDate: Date = Date.now
    @State private var recordedMillage: Double?

    @State private var nextDate: Date?
    @State private var nextMillage: Double?
    @State private var isUsingNextDate = false

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Comment (optional)",
                          text: Binding(
                            get: {
                                comment ?? ""
                            },
                            set: { value in
                                comment = value
                            }))

                Section("Current Event") {
                    DatePicker(
                        selection: $recordedDate,
                        displayedComponents: .date
                    ) {
                        Text("Date")
                    }

                    TextField("Millage", value: $recordedMillage, format: .number)
                        .keyboardType(.numberPad)
                }

                Section("Next Occurrence") {
                    Toggle("Use next date?", isOn: $isUsingNextDate.animation())
                    if isUsingNextDate {
                        DatePicker(
                            selection: Binding(
                                get: {
                                    nextDate ?? Date.now
                                },
                                set: { value in
                                    nextDate = value
                                }),
                            displayedComponents: .date
                        ) {
                            Text("Date")
                        }
                    }

                    TextField("Millage", value: $nextMillage, format: .number)
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
            nextDate: isUsingNextDate ? nextDate : nil,
            recordedMillage: recordedMillage,
            nextMillage: nextMillage
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
            millage: 12345,
            id: UUID().uuidString
        )
        return
            CreateEventView(vehicle: vehicle)
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
