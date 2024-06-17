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

    var body: some View {
        List {
            ForEach(vehicle.unwrappedEvents, id: \.self) { event in
                EventRowView(event: event)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(vehicle.id)")
        .navigationBarTitleDisplayMode(.inline)
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
                recordedDate: Date.init(timeIntervalSinceNow: 100 * numberDouble),
                nextDate: Date(timeIntervalSinceNow: 100_000_000 + 1000 * numberDouble),
                recordedMillage: 1234 + 123 * numberDouble,
                nextMillage: 10000 + 123 * numberDouble
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
