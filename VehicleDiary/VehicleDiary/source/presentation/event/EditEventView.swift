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
    @State private var recordedMillage: Double?

    @State private var nextDate: Date?
    @State private var nextMillage: Double?
    @State private var isUsingNextDate: Bool

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Comment (optional)", text: $comment)

                Section("Recorded") {
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
            .navigationTitle("Edit Event")
            .navigationBarTitleDisplayMode(.inline)

            Button("Update") {
                updateEvent()
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

    init(event: VEvent) {
        self.event = event
        name = event.name
        comment = event.comment ?? ""
        recordedDate = event.recordedDate
        recordedMillage = event.recordedMillage
        nextDate = event.nextDate
        nextMillage = event.nextMillage
        isUsingNextDate = event.nextDate != nil
    }

    private func updateEvent() {
        event.name = name
        event.comment = comment
        event.recordedDate = recordedDate
        event.nextDate = isUsingNextDate ? nextDate : nil
        event.recordedMillage = recordedMillage
        event.nextMillage = nextMillage
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
        let event = VEvent(
            name: "Test Event",
            comment: "Test comment",
            recordedDate: Date.now,
            nextDate: Date.distantFuture,
            recordedMillage: 10_000,
            nextMillage: 20_000,
            id: UUID().uuidString,
            vehicle: vehicle
        )
        return EditEventView(event: event)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
