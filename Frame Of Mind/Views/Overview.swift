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
            
            /*
            NavigationLink {
                AddMoodView()
            } label: {
                Text("Eintrag hinzufügen")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 350)
                    .background(Color.black.opacity(0.1))
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1))
                    .padding()
            }
             */
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
