//
//  AppTabView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-19.
//

import SwiftUI
import SwiftData

struct AppTabView: View {
    var body: some View {
        TabView {
            VehiclesListView()
                .tabItem {
                    Label("Records", systemImage: "book.pages")
                }
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
            mileage: 10000,
            id: UUID().uuidString
        )
        container.mainContext.insert(vehicle)

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
                upcomingDate: Date(timeIntervalSinceNow: Double.random(in: 1_000_000...10_000_000) + 100 * numberDouble),
                recordedMileage: Double.random(in: 1_000...10_000) + 1_203 * numberDouble,
                upcomingMileage: Double.random(in: 10_000...10_500) + 1_230 * numberDouble
            )
            events.append(event)
        }
        vehicle.events = events
        return AppTabView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
