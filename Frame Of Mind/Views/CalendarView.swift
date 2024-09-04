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
    
    @State private var startDate: Date = Date()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(dates(for: startDate), id: \.self) { date in
                    VStack {
                        Text(dayAbbreviation(for: date))
                            .font(.subheadline)
                            .fontWeight(isSameDay(date) ? .bold : .regular)
                            .foregroundStyle(isSameDay(date) ? .blue : .secondary.opacity(0.5))
                        
                        Text(date.dayString)
                            .font(.title2)
                            .fontWeight(isSameDay(date) ? .bold : .regular)
                            .foregroundStyle(isSameDay(date) ? .blue : .secondary.opacity(0.5))
                            .overlay(isSameDay(date) ? Capsule().stroke(Color.blue.opacity(0.75), lineWidth: 0.75).frame(width: 35, height: 45) : nil)
                            .padding(.top, 8)
                            .onTapGesture {
                                withAnimation(.interpolatingSpring(duration: 0.0)) {
                                    selectedDate = date  // Datum aktualisieren
                                }
                            }
                            .shadow(color: isSameDay(date) ? .blue : .white, radius: 10)
                            .padding(.bottom, isSameDay(date) ? 32 : 0)
                    }
                }
            }
            .padding()
        }
        .onAppear { // Startdatum wird beim Laden der Ansicht gesetzt
            startDate = calendar.startOfDay(for: Date())
        }
    }
    
    //MARK: - Funktionen
    
    //berechnet die Tage 7 Tage vor- und nachher für die Scrollview
    private func dates(for startDate: Date) -> [Date] {
        //legt die Anzahl von >Tagem vor und nach dem Startdatum fest (startDatum ist der aktuelle Tag)
        let previousDays = -7
        let followingDays = 7
        return (previousDays..<followingDays).compactMap { // erstellt eine Liste von -14 bis 13 und filtert nil-Werte aus zeigt also nur gültige Werte an
            calendar.date(byAdding: .day, value: $0, to: startDate) // verschiebt das Startdatum um die jeweiligen Werte in Tagen ($0 = Tage die zu startDate addiert oder subtrahiert werden)
        }
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
