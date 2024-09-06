//
//  Overview.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI
import SwiftData

struct Overview: View {
    
    @State private var selectedDate: Date = Date()
    
    private var currentDate: Date = Date()
    
    //MARK: - Body View
    var body: some View {
        NavigationStack {
            
            CalendarView(selectedDate: $selectedDate)
            ListView(selectedDate: selectedDate)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) { // Button zum Hinzufügen eines Eintrages
                        NavigationLink {
                            AddMoodView(selectedDate: selectedDate)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Übersicht")
        }
    }
}

/*
 #Preview {
 Overview()
 .modelContainer(DataManager.previewContainer)
 }
 */
