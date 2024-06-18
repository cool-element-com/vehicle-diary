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
                Text(event.comment ?? "")

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
                    HStack {
                        Text("mileage".uppercased())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(event.upcomingEventInMileageString())
                    }
                }
                .eventApproachBackground(approach: event.approach)
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

struct EventApproachBackgroundModifier: ViewModifier {
    let approach: VEvent.Approach
    init(approach: VEvent.Approach) {
        self.approach = approach
    }

    func body(content: Content) -> some View {
        switch approach {
        case .inDays(_),
                .afterMileage(_):
            content
                .listRowBackground(Color.red.opacity(0.5))
        case .notYet:
            content
        }
    }
}

extension View {
    func eventApproachBackground(approach: VEvent.Approach) -> some View {
        modifier(EventApproachBackgroundModifier(approach: approach))
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
            mileage: 19845,
            id: UUID().uuidString
        )
        let event = VEvent(
            name: "Test Event",
            comment: "Test comment",
            recordedDate: Date.now,
            upcomingDate: Date(timeIntervalSinceNow: 360000),
            recordedMileage: 10_000,
            upcomingMileage: 20_000,
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
