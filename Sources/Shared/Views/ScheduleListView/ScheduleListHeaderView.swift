//
//  ScheduleListHeaderView.swift
//  SMHSSchedule
//
//  Created by Jevon Mao on 4/27/21.
//

import SwiftUI

struct ScheduleListHeaderView: View {
    var scheduleWeek: ScheduleWeek
    var body: some View {
        HStack {
            Label(
                title: {
                    Text(scheduleWeek.weekText)
                        .font(.headline)
                        .fontWeight(.semibold)
                },
                icon: {
                    Image(systemSymbol: .calendar)
                        .font(.system(size: 16))
                }
            )
            .foregroundColor(Color.primary)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 3)
    }
}

struct ScheduleListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListHeaderView(scheduleWeek: ScheduleWeek(scheduleDays: [ScheduleDay(id: 0,
                                                                                     date: Date(),
                                                                                    scheduleText: "")]))
    }
}
