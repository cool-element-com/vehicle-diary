//
//  EventView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EventView: View {
    @Environment(\.locale) var locale
    let event: VEvent
    @State private var isShowingEditView = false

    var body: some View {
        VStack {
            Form {
                Text(event.name)
                Section("comment") {
                    Text(event.comment ?? Constants.Symbol.notAvailable)
                }

                Section("Recorded") {
                    HStack {
                        Text("Date".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.recordedDateString())
                    }
                    HStack {
                        Text("Mileage".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.recordedMileageMeasurementString())
                    }
                }

                Section("Next Occurrence") {
                    HStack {
                        Text("Date".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.upcomingDateString())
                    }
                    HStack {
                        Text("Mileage".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.upcomingMileageMeasurementString())
                    }
                }

                Section("Expected") {
                    HStack {
                        Text("time".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.upcomingEventInDaysString())
                    }
                    .eventApproachListRowBackground(approach: event.approach, measurement: .time)

                    HStack {
                        Text("mileage".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.upcomingEventInMileageString())
                    }
                    .eventApproachListRowBackground(approach: event.approach, measurement: .millage)
                }
            }
            .navigationTitle(event.name)
            .navigationBarTitleDisplayMode(.inline)

            Button("Edit") {
                isShowingEditView = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $isShowingEditView, content: {
            EditEventView(event: event)
        })
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
            mileage: 20000,
            id: UUID().uuidString
        )
        let event = VEvent(
            name: "Test Event",
            comment: """
this is a comment for a long event
new line is also very important
as third line as well
""",
            recordedDate: Date.now,
            upcomingDate: nil,
            recordedMileage: 10_000,
            upcomingMileage: 15_000,
            id: UUID().uuidString
        )
        vehicle.events = [event]
        container.mainContext.insert(vehicle)
        return NavigationStack {
            EventView(event: event)
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
