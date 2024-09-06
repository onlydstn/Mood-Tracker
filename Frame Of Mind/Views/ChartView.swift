//
//  ChartView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import SwiftUI
import Charts
import SwiftData

struct ChartView: View {
    @State private var selectedStartDate: Date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
    @State private var selectedEndDate: Date = Date()
    @Query private var moods: [Mood]
    
    // Emotionen für Liste vordefinieren
    let allMoods: [String] = ["😃", "😢", "😡", "🤩", "😴", "😐"]
    
    // Filter für die Einträge nach ausgewählten Datum
    var filteredMoods: [Mood] {
        moods.filter { $0.date >= selectedStartDate && $0.date <= selectedEndDate }
    }
    
    // Balken nach jeweiliger Stimmung
    var moodCounts: [String: Int] {
        var counts = Dictionary(grouping: filteredMoods, by: { $0.emoji })
            .mapValues { $0.count }
        
        for mood in allMoods {
            counts[mood] = counts[mood] ?? 0
        }
        return counts
    }
    
    // MARK: - Zeitraum Auswahl
    var body: some View {
        VStack {
            HStack {
                Text("Startdatum:")
                    .font(.headline)
                Spacer()
                DatePicker("", selection: $selectedStartDate, in: ...selectedEndDate, displayedComponents: .date)
                    .labelsHidden()
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Enddatum:")
                    .font(.headline)
                Spacer()
                DatePicker("", selection: $selectedEndDate, in: selectedStartDate..., displayedComponents: .date)
                    .labelsHidden()
                    .padding(.horizontal)
            }
            .padding(.horizontal)
        }
        
        // MARK: - Balkendiagramm
        
        withAnimation(.easeInOut(duration: 1)) {
            Chart {
                ForEach(moodCounts.keys.sorted(), id: \.self) { emoji in
                    BarMark(
                        x: .value("Stimmung", emoji),
                        y: .value("Anzahl", moodCounts[emoji] ?? 0)
                    )
                    .foregroundStyle(colorForMood(emoji))
                    .annotation(position: .top) {
                        Text("\(moodCounts[emoji] ?? 0)")
                            .font(.caption)
                            .foregroundStyle(.primary)
                    }
                }
            }
            .chartXAxisLabel("Stimmungen")
            .chartYAxisLabel("Anzahl")
            .frame(height: 500)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6).opacity(0.5)))
        }
        Spacer()
    }
}
    
    
    //MARK: - Funktionen
    func colorForMood(_ emoji: String) -> Color {
        switch emoji {
        case "😃": return .yellow
        case "😢": return .blue
        case "😡": return .red
        case "🤩": return .green
        case "😴": return .orange
        case "😐": return .black
        default: return .gray
        }
    }




#Preview {
    ChartView()
}
