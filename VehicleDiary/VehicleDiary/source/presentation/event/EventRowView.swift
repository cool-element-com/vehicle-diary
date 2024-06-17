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
                }
            }
            .padding(.vertical, 0)

            HStack(alignment: .top) {
                EventTimeMillageView(event: event, occurrence: .recorded)
                EventTimeMillageView(event: event, occurrence: .next)
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
                    comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil,
                    recordedDate: Date.init(timeIntervalSinceNow: 100 * numberDouble),
                    nextDate: /*number.isMultiple(of: 3) ? Date(timeIntervalSinceNow: 100_000_000 + 1000 * numberDouble) : */nil,
                    recordedMillage: number.isMultiple(of: 4) ? (1200034 + 123 * numberDouble) : nil,
                    nextMillage: number.isMultiple(of: 5) ? 10000 + 123 * numberDouble : nil)
                return EventRowView(event: event)
                    .modelContainer(container)
            }
        }
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
