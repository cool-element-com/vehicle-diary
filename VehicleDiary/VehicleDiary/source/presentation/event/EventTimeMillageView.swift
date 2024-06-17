//
//  EventTimeMillageView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EventTimeMillageView: View {
    enum Occurrence {
        case recorded
        case next
    }

    @Environment(\.locale) private var locale
    let event: VEvent
    let occurrence: Occurrence

    var title: String {
        let result: String
        switch occurrence {
        case .recorded:
            result = "recorded"
        case .next:
            result = "next"
        }
        return result.uppercased()
    }
    var dateString: String? {
        let result: String?
        switch occurrence {
        case .recorded:
            result = event.recordedDateString()
        case .next:
            if event.nextDate != nil {
                result = event.nextDateString()
            } else {
                result = nil
            }
        }
        return result
    }
    var millage: Double? {
        let result: Double?
        switch occurrence {
        case .recorded:
            result = event.recordedMillage
        case .next:
            result = event.nextMillage
        }
        return result
    }
    var millageMeasurement: Measurement<UnitLength> {
        let result: Measurement<UnitLength>
        switch occurrence {
        case .recorded:
            result = event.recordedMillageMeasurement
        case .next:
            result = event.nextMillageMeasurement
        }
        return result
    }
    var backgroundColor: Color {
        switch occurrence {
        case .recorded:
                .blue
        case .next:
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
                if let dateString {
                    Text(dateString)
                } else {
                    Text("-")
                }
            }
            .font(.caption)
            .fontWeight(.medium)
            HStack(alignment: .firstTextBaseline) {
                Text("millage".uppercased())
                    .font(.caption2)
                    .fontWeight(.light)
                Spacer()
                if millage != nil {
                    Text(millageMeasurement.formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .road
                        ).locale(locale)
                    ))
                } else {
                    Text("-")
                }
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
