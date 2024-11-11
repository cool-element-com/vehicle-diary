//
//  EventRowView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-16.
//

import SwiftUI
import SwiftData

struct EventRowView: View {
    let event: VEvent

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title3.bold())
                if !event.unwrappedComment.isEmpty {
                    Text(event.unwrappedComment)
                        .font(.caption)
                        .lineLimit(2)
                        .padding(.horizontal, 4)
                }
            }
            .padding(.vertical, 0)

            HStack(alignment: .top) {
                if event.isReoccurring {
                    EventTimeMileageView(event: event, occurrence: .recorded)
                    EventTimeMileageView(event: event, occurrence: event.isCompleted ? .completed : .upcoming)
                } else {
                    EventTimeMileageView(event: event, occurrence: .recorded)
                }

            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
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

        for number in 0..<20 {
            let numberDouble = Double(number)
            let event = VEvent(
                name: "Event \(number)",
                comment: number.isMultiple(of: 2) ? """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""" : nil,
                recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 100000...1000000) * numberDouble),
                upcomingDate: Date.init(timeIntervalSinceNow: Double.random(in: 100000...1000000) * numberDouble),
                recordedMileage: number.isMultiple(of: 2) 
                ? (Double.random(in: 5000...12000) + 123 * numberDouble)
                : nil,
                upcomingMileage: number.isMultiple(of: 2) 
                ? Double.random(in: 10000...10200) + 123 * numberDouble
                : nil)
            vehicle.events?.append(event)
        }

        return List {
            ForEach(vehicle.events ?? []) { event in
                return EventRowView(event: event)
            }
        }
        .modelContainer(container)
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
