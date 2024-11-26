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

    private var textColorPrimary: Color {
        Theme.default.defaultConfig.textColor
    }
    private var textColorSecondary: Color {
        Theme.default.defaultConfig.foregroundColor
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title3.bold())
                    .foregroundStyle(textColorPrimary)
                    .padding(.bottom, 2)
                EventTimeMileageView(
                    event: event,
                    occurrence: .recorded
                )
                .padding(.horizontal, 0)
                .padding(.bottom, 4)
                if !event.unwrappedComment.isEmpty {
                    Text(event.unwrappedComment)
                        .font(.caption)
                        .foregroundStyle(textColorPrimary.opacity(0.65))
                        .lineLimit(2)
                        .padding(.horizontal, 8)
                }
            }
            .padding(.bottom, 4)
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
        .padding(0)
    }
}

#Preview("EventRowView") {
        let event = VEvent(
            name: "test event",
            comment: """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""" ,
            recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 100000...1000000)),
            upcomingDate: nil,
            recordedMileage: Double.random(in: 5000...12000),
            upcomingMileage: Double.random(in: 10000...10200),
            isCompleted: false)
        return EventRowView(event: event)
}

#Preview("EventRowView1") {
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
        let event = VEvent(
            name: "test event",
            comment: """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""" ,
            recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 100000...1000000)),
            upcomingDate: nil,
            recordedMileage: Double.random(in: 5000...12000),
            upcomingMileage: Double.random(in: 10000...10200),
            isCompleted: false)
        vehicle.events?.append(event)
        return EventRowView(event: event)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
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
