//
//  Widgets.swift
//  Widgets
//
//  Created by Jevon Mao on 5/1/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let viewModel: ScheduleViewModel = ScheduleViewModel()
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), scheduleDay: ScheduleDay(id: 1, date: Date(), scheduleText: "Special Virtual Schedule Day 2\nWednesday, April 21 \nSpecial Virtual Day 2 \n(40 minute classes) \n\nPeriod 2                         8:00-8:40 \n\nPeriod 3                         8:45-9:25 \n(10 minute break) \n\nPeriod 4                         9:35-10:15 \n\nPeriod 5                         10:20-11:40 \n(40 minute DIVE Presentation) \n\nNutrition                      11:40-12:10 \n\nPeriod 6                         12:15-12:55 \n\nPeriod 7                         1:00-1:40 \n\nPeriod 1                         1:45-2:25 \n-------------------------------\n\n\nClasses 8:00-2:25\n\nDive Presentation\n\nB JV Tennis vs JSerra 5:30\n\nB JV/V LAX vs JSerra 7:30/5:30\n\nB JV/V Vball vs Bosco 3:00/3:00\n\nB V Basketball vs Bosco 7:00\n\nB V Golf @ Hunt Beach 3:00\n\nG JV Tennis vs Orange Luth 3:15\n\nG V LAX @ JSerra 5:30\n\nG V Tennis @ Orange Luth 2:30\n\nJV Gold Baseball vs JSerra 3:30\n\nJV/V Baseball @ South Hills 2:30/3:15\n\n\n\nV Sball vs Mission Viejo 3:30\n"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), scheduleDay: viewModel.scheduleWeeks.first?.scheduleDays.first)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        guard let week = viewModel.scheduleWeeks.first else {return}
        for day in week.scheduleDays {
            entries.append(.init(date: day.date, scheduleDay: day))
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let scheduleDay: ScheduleDay?
}

struct WidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.scheduleDay?.scheduleText ?? "")
                .foregroundColor(Color.platformBackground)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(
            LinearGradient(gradient: .init(colors: [.primary, Color.primary.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

@main
struct Widgets: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Today's Schedle")
        .supportedFamilies([.systemLarge])
        .description("Quickly glance today's class schedule, beautifully presented on the home screen.")
    }
}

struct Widgets_Previews: PreviewProvider {
    static var previews: some View {
        WidgetsEntryView(entry: SimpleEntry(date: Date(), scheduleDay: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
