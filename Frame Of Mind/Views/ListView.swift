//
//  ListView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 06.09.24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var context
    @Query var moods: [Mood]
    
    init(selectedDate: Date) {
        let start = selectedDate.setTime(hour: 0, minute: 0)
        let end = selectedDate.setTime(hour: 23, minute: 59)
        
        let predicate = #Predicate<Mood> {
            $0.date >= start && $0.date <= end
        }
        
        _moods = Query(filter: predicate, sort: [SortDescriptor(\Mood.date, order: .reverse)])
    }
    
    var body: some View {
        List {
            ForEach(moods) { mood in
                MoodListView(mood: mood)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteEntry(mood)
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
    }
    
    //MARK: - Funktion zum Löschen eines Datenbankeintrages
    private func deleteEntry(_ mood: Mood) {
        context.delete(mood)
    }
}

#Preview {
    ListView(selectedDate: Date())
}
