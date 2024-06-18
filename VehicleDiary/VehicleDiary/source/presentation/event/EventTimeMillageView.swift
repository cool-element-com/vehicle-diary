//
//  EventTimeMileageView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EventTimeMileageView: View {
    enum Occurrence {
        case recorded
        case upcoming
    }

    @Environment(\.locale) private var locale
    let event: VEvent
    let occurrence: Occurrence

    var title: String {
        let result: String
        switch occurrence {
        case .recorded:
            result = "recorded"
        case .upcoming:
            result = "upcoming"
        }
        return result.uppercased()
    }
    var dateString: String {
        let result: String
        switch occurrence {
        case .recorded:
            result = event.recordedDateString()
        case .upcoming:
            result = event.upcomingDateString()
        }
        return result
    }
    var mileageMeasurementString: String {
        let result: String
        switch occurrence {
        case .recorded:
            result = event.recordedMileageMeasurementString()
        case .upcoming:
            result = event.upcomingMileageMeasurementString()
        }
        return result
    }
    var backgroundColor: Color {
        let color: Color
        switch occurrence {
        case .recorded:
            color = .blue
        case .upcoming:
            let approaching: [VEvent.Approach] = [
                .inDays,
                .afterMileage
            ]
            if approaching.contains(event.approach) {
                color = .red
            } else {
                color = .green
            }
        }
        return color
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.vertical, 2)
                .font(.caption2)
                .fontWeight(.none)

            HStack(alignment: .firstTextBaseline) {
                Text("date".uppercased())
                    .font(.caption2)
                    .fontWeight(.light)
                Spacer()
                Text(dateString)
            }
            .font(.caption)
            .fontWeight(.medium)

            HStack(alignment: .firstTextBaseline) {
                Text("mileage".uppercased())
                    .font(.caption2)
                    .fontWeight(.light)
                Spacer()
                Text(mileageMeasurementString)
            }
            .font(.caption)
            .fontWeight(.medium)
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
        .frame(height: 60)
        .padding(.vertical, 2)
        .padding(.horizontal, 8)
        .background(content: {
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor.opacity(0.25))
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
                upcomingDate: nil,
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
