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
        VStack(alignment: .leading) {
            Text(currentMonthAndYear)
                .font(.headline)
                .padding(.bottom, 8)
                .padding(.leading, 16)
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 32) {
                        ForEach(dates(for: startDate), id: \.self) { date in
                            VStack {
                                Text(dayShortcut(for: date))
                                    .font(.subheadline)
                                    .fontWeight(isSameDay(date) ? .bold : .regular)
                                    .foregroundStyle(isSameDay(date) ? .blue : (isWeekend(date) ? .red.opacity(0.5) : .secondary.opacity(0.5))) // Wochenendtage hervorheben
                                
                                Text(date.dayString)
                                    .font(.title2)
                                    .fontWeight(isSameDay(date) ? .bold : .regular)
                                    .foregroundStyle(isSameDay(date) ? .blue : (isWeekend(date) ? .red.opacity(0.5) : .secondary.opacity(0.5))) // Wochenendtage hervorheben
                                    .overlay(isSameDay(date) ? Capsule().stroke(Color.blue.opacity(0.75), lineWidth: 0.75).frame(width: 35, height: 45) : nil)
                                    .padding(.top, 8)
                                    .onTapGesture {
                                        withAnimation(.interpolatingSpring(duration: 0.0)) {
                                            selectedDate = date  // Datum aktualisieren
                                            proxy.scrollTo(selectedDate, anchor: .center) // scrollt zum heutigen Tag
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
                    updateMonth(for: startDate)
                    proxy.scrollTo(selectedDate, anchor: .center) // scrollt automatisch zum heutigen Tag und zeigt diesen mit anchor: .center mittig an
                }
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
        return formatter.string(from: selectedDate)
    }
    
    // aktualisiert den angezeigten Monat wenn Datum ausgewählt wird
    private func updateMonth(for date: Date) {
        selectedDate = date
    }
    
    //berechnet die Tage 7 Tage vor- und nachher für die Scrollview
    private func dates(for startDate: Date) -> [Date] {
        //legt die Anzahl von >Tagem vor und nach dem Startdatum fest (startDatum ist der aktuelle Tag)
        let previousDays = -7
        let followingDays = 7
        return (previousDays..<followingDays).compactMap { // erstellt eine Liste von -14 bis 13 und filtert nil-Werte aus zeigt also nur gültige Werte an
            calendar.date(byAdding: .day, value: $0, to: startDate) // verschiebt das Startdatum um die jeweiligen Werte in Tagen ($0 = Tage die zu startDate addiert oder subtrahiert werden)
        }
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
