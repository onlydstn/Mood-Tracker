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
    
    @Query private var moods: [Mood]
    
    var body: some View {
        NavigationStack {
            CalendarView()
            List {
                ForEach(moods) { mood in
                    NavigationLink(destination: DetailView(mood: mood)) {
                        MoodListView(mood: mood)
                            .frame(width: 400)
                            .padding(.leading)
                    }
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
    
    private func deleteEntry(_ mood: Mood) {
        context.delete(mood)
    }
}

#Preview {
    Overview()
        .modelContainer(DataManager.previewContainer)
}
