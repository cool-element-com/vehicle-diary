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
        switch occurrence {
        case .recorded:
                .blue
        case .upcoming:
                .orange
        }
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
        return List {
            ForEach(0..<20, id: \.self) { number in
                let numberDouble = Double(number)
                let event = VEvent(
                    name: "Event \(number)",
                    comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil,
                    recordedDate: Date.init(timeIntervalSinceNow: 100 * numberDouble),
                    upcomingDate: /*number.isMultiple(of: 3) ? Date(timeIntervalSinceNow: 100_000_000 + 1000 * numberDouble) : */nil,
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
