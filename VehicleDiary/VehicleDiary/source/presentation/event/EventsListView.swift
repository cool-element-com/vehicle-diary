//
//  EventsListView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-16.
//

import SwiftUI
import SwiftData

struct EventsListView: View {

    enum Visibility {
        case showAll
        case showCompleted
        case showNotCompleted
    }

    @Bindable var vehicle: Vehicle
    @State private var sortOrder = [
        SortDescriptor(\VEvent.recordedDate)
    ]
    @State private var visibility: Visibility = .showNotCompleted

    var body: some View {
        SortableEventsListView(
            vehicle: vehicle,
            sortOrder: sortOrder,
            visibility: visibility
        )
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort events", selection: $sortOrder) {
                        Text("Sort by upcoming occurrence date")
                            .tag([
                                SortDescriptor(\VEvent.upcomingDate)
                            ])
                        Text("Sort by upcoming mileage")
                            .tag([
                                SortDescriptor(\VEvent.upcomingMileage)
                            ])
                        Text("Sort by recorded date")
                            .tag([
                                SortDescriptor(\VEvent.recordedDate)
                            ])
                        Text("Sort by recorded mileage")
                            .tag([
                                SortDescriptor(\VEvent.recordedMileage)
                            ])
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\VEvent.name)
                            ])
                    }
                    Picker("Show completed", selection: $visibility) {
                        Text("Show all")
                            .tag(Visibility.showAll)
                        Text("Show completed")
                            .tag(Visibility.showCompleted)
                        Text("Show not completed")
                            .tag(Visibility.showNotCompleted)

                    }
                }
            }
#if DEBUG
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Sample Data") {
                    createSampleData()
                }
            }
        }
#endif
    }

#if DEBUG
    private func createSampleData() {
        var events = [VEvent]()
        for number in 0..<20 {
            let numberDouble = Double(number)
            let event = VEvent(
                name: "Event \(number)",
                comment: number.isMultiple(of: 2) ? """
this is a comment for a long event
new line is also very important
as third line as well
""" : nil,
                recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000) + 100 * numberDouble),
                upcomingDate: Date(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000) + 100 * numberDouble),
                recordedMileage: Double.random(in: 1_000...10_000) + 1_203 * numberDouble,
                upcomingMileage: Double.random(in: 10_000...10_500) + 1_230 * numberDouble
            )
            events.append(event)
        }
        vehicle.events = events
    }
#endif
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(
            brand: "Subaru",
            model: "Outback",
            comment: "hello",
            mileage: 10000,
            id: UUID().uuidString
        )
        container.mainContext.insert(vehicle)

        return NavigationStack {
            EventsListView(vehicle: vehicle)
                    .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
