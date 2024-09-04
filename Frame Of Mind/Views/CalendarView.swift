//
//  CalendarView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    
    var calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.firstWeekday = 2 // 2 ist Monatg
        return cal
    }()
    
    @State private var startDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(currentMonthAndYear)
                    .font(.headline)
                    .padding(.bottom, 8)
                Spacer()
            }
            .padding(.leading, 16)
            
            HStack {
                Spacer()
                HStack(spacing: 24) {
                    ForEach(weekDates(for: startDate), id: \.self) { date in
                        VStack {
                            Text(dayShortcut(for: date))
                                .font(.subheadline)
                                .fontWeight(isSameDay(date) ? .bold : .regular)
                                .foregroundStyle(isSameDay(date) ? .blue : (isWeekend(date) ? .red.opacity(0.5) : .secondary.opacity(0.5))) // Wochenendtage hervorheben
                            
                            Text(date.dayString)
                                .font(.title2)
                                .fontWeight(isSameDay(date) ? .bold : .regular)
                                .foregroundStyle(isSameDay(date) ? .blue : (isWeekend(date) ? .red.opacity(0.5) : .secondary.opacity(0.5))) // Wochenendtage hervorheben
                                .overlay(isSameDay(date) ? Capsule().stroke(Color.blue, lineWidth: 1).frame(width: 35, height: 45) : nil)
                                .padding(.top, 8)
                                .onTapGesture {
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        selectedDate = date  // Datum aktualisieren
                                    }
                                }
                                .shadow(color: isSameDay(date) ? .blue : .white, radius: 10)
                                .padding(.bottom, isSameDay(date) ? 40 : 0)
                        }
                        .frame(width: 30, height: 50)
                    }
                }
                Spacer()
            }
                .padding()
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                nextWeek()
                            } else if value.translation.width > 0 {
                                previousWeek()
                            }
                        }
                )
                .onAppear { // Startdatum wird beim Laden der Ansicht gesetzt
                    startDate = startOfWeek(for: Date())
                    selectedDate = Date()
                }
            }
        }
    
    
    //MARK: - Funktionen
    
    private func isWeekend(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7 // sonntag ist 1 und Samstag ist 7
    }
    
    //zeigt Monat und Jahr des aktuellen Datum an
    private var currentMonthAndYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: startDate)
    }
    
    private func weekDates(for startDate: Date) -> [Date] {
        let daysInWeek = 7
        return (0..<daysInWeek).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: startDate)
        }
    }
    
    private func startOfWeek(for date: Date) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        let startOfWeek = calendar.date(from: components) ?? date
        let weekday = calendar.component(.weekday, from: startOfWeek)
        let daysToSubtract = weekday == 1 ? 6 : weekday - 2
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: startOfWeek) ?? startOfWeek
    }
    
    private func nextWeek() {
        guard let newStartDate = calendar.date(byAdding: .day, value: 7, to: startDate) else { return }
        startDate = newStartDate
    }
    
    private func previousWeek() {
        guard let newStartDate = calendar.date(byAdding: .day, value: -7, to: startDate) else { return }
        startDate = newStartDate
    }
    
    // Wochentage als Abkürzung anzeigen (also So. Mo. Di etc..)
    private func dayShortcut(for date: Date) -> String {
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
