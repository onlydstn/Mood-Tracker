//
//  CalendarView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import SwiftUI

struct CalendarView: View {
    //@State private var selectedDate = Date()
    @Binding var selectedDate: Date
    var calendar = Calendar(identifier: .gregorian)
    
    var body: some View {
        HStack(spacing: 32) {
            ForEach(weekDates(), id: \.self) { date in
                VStack {
                    Text(dayAbbreviation(for: date)) // Tag als Text
                        .font(.subheadline)
                        .fontWeight(isSameDay(date) ? .bold : .regular)
                        .foregroundStyle(isSameDay(date) ? .blue : .secondary.opacity(0.5))
                    Text(date.dayString) // Datum als Zahl
                        .font(.title2)
                        .fontWeight(isSameDay(date) ? .bold : .regular)
                        .foregroundStyle(isSameDay(date) ? .blue : .secondary.opacity(0.5))
                        .overlay(isSameDay(date) ? Capsule().stroke(Color.blue.opacity(0.75), lineWidth: 0.75).frame(width: 35, height: 45) : nil)
                        .padding(.top, 8)
                        .onTapGesture {
                            withAnimation(.interpolatingSpring(duration: 0.0)) {
                                selectedDate = date
                            }
                        }
                        .shadow(color: isSameDay(date) ? .blue : .white, radius: 10)
                        .padding(.bottom, isSameDay(date) ? 32 : 0)
                }
            }
        }
        .frame(width: 360, height: 100)
        //        .overlay(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)).fill(.clear).stroke(Color.blue, lineWidth: 1))
        //        .background(.blue.opacity(0.10))
        //        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        
        .padding()
    }
    
    // gibt Wochentage ab dem letzen Montag aus
    private func weekDates() -> [Date] {
        let today = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) } // gibt eine Ganze Woche also 7 Tage zurück
    }
    
    // Wochentage als Abkürzung anzeigen (also So. Mo. Di etc..)
    private func dayAbbreviation(for date: Date) -> String {
        date.formatted(.dateTime.weekday(.short).locale(Locale(identifier: "de_DE")))
    }
    
    // prüft, ob das ausgewählte Datum das aktuelle Datum entspricht
    private func isSameDay(_ date: Date) -> Bool {
        calendar.isDate(selectedDate, inSameDayAs: date)
    }
}


//#Preview {
//    CalendarView(selectedDate: $selectedDate)
//}
