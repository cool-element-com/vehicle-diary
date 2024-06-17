//
//  EventsListView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-16.
//

import SwiftUI
import SwiftData

struct EventsListView: View {
    @Bindable var vehicle: Vehicle
    @State private var sortOrder = [
        SortDescriptor(\VEvent.recordedDate)
    ]

    var body: some View {
        SortableEventsListView(vehicle: vehicle, sortOrder: sortOrder)
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort by name", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\VEvent.name)
                            ])
                    }
                    Picker("Sort by next event", selection: $sortOrder) {
                        Text("Sort by next occurrence date")
                            .tag([
                                SortDescriptor(\VEvent.nextDate)
                            ])
                        Text("Sort by next millage")
                            .tag([
                                SortDescriptor(\VEvent.nextMillage)
                            ])
                    }
                    Picker("Sort by recorded event", selection: $sortOrder) {
                        Text("Sort by recorded date")
                            .tag([
                                SortDescriptor(\VEvent.recordedDate)
                            ])
                        Text("Sort by recorded millage")
                            .tag([
                                SortDescriptor(\VEvent.recordedMillage)
                            ])
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
                comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil,
                recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000_000) + 100 * numberDouble),
                nextDate: Date(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000_000) + 1_000 * numberDouble),
                recordedMillage: Double.random(in: 1_000...50_000) + 1_203 * numberDouble,
                nextMillage: Double.random(in: 20_000...100_000) + 1_230 * numberDouble
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
        let vehicle = Vehicle(brand: "Subaru", model: "Outback", comment: "hello", millage: 12345, id: UUID().uuidString)
        container.mainContext.insert(vehicle)

        return NavigationStack {
            EventsListView(vehicle: vehicle)
                    .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
