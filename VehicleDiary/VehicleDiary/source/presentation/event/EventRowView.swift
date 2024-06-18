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
                }
            }
            .padding(.vertical, 0)

            HStack(alignment: .top) {
                EventTimeMileageView(event: event, occurrence: .recorded)
                EventTimeMileageView(event: event, occurrence: .upcoming)
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        return List {
            ForEach(0..<20, id: \.self) { number in
                let numberDouble = Double(number)
                let event = VEvent(
                    name: "Event \(number)",
                    comment: number.isMultiple(of: 2) ? """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""" : nil,
                    recordedDate: Date.init(timeIntervalSinceNow: 100 * numberDouble),
                    upcomingDate: nil,
                    recordedMileage: number.isMultiple(of: 4) ? (1200034 + 123 * numberDouble) : nil,
                    upcomingMileage: number.isMultiple(of: 5) ? 10000 + 123 * numberDouble : nil)
                return EventRowView(event: event)
                    .modelContainer(container)
            }
        }
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
