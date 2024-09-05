//
//  Overview.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI
import SwiftData

struct Overview: View {
    @Environment(\.modelContext) private var context
    //@Query private var moods: [Mood]
    @Query(sort: [SortDescriptor(\Mood.date, order: .reverse)]) var moods: [Mood]
    @State private var selectedDate: Date = Date()
    @State private var isShowing = false
    
    //MARK: - Computed Property zum Filtern der Listeneinträge nach selektiertem Datum
    var filteredMoods: [Mood] { // speichert gefilterte Einträge
        return moods.filter { mood in
            Calendar.current.isDate(mood.date, inSameDayAs: selectedDate)
        }
    }
    
    //MARK: - Body View
    var body: some View {
        NavigationStack {
            CalendarView(selectedDate: $selectedDate)
            List {
                ForEach(filteredMoods) { mood in // Liste filtert nach ausgewähltem Datum und zeigt nur diese Elemente an
                    Button {
                        isShowing.toggle()
                    } label: {
                        MoodListView(mood: mood)
                    }
                            .frame(width: 400)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteEntry(mood)
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
                    .sheet(isPresented: $isShowing, content: {
                        DetailView(mood: mood)
                            .presentationDetents([.fraction(0.4), .height(490), .large])
                    })
                }
                .listRowSeparator(.hidden)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { // Button zum Hinzufügen eines Eintrages
                    NavigationLink {
                        AddMoodView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Übersicht")
        }
    }
    
    //MARK: - Funktion zum Löschen eines Datenbankeintrages
    private func deleteEntry(_ mood: Mood) {
        context.delete(mood)
    }
}


#Preview {
    Overview()
        .modelContainer(DataManager.previewContainer)
}
