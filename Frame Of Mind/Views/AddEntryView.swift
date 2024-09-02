//
//  AddEntryView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI
import SwiftData

struct AddEntryView: View {
    @Environment(\.modelContext) private var context
    
    @State private var selectedEmoji: Moods = .happy
    @State private var title: String = ""
    @State private var bodyText: String = ""
    @State private var date: Date = Date()
    
    
    @Binding var showingSheet: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Picker("😃", selection: $selectedEmoji) {
                    ForEach(Moods.allCases) { emoji in
                        Text(emoji.emoji).tag(emoji)
                    }
                }
                .font(.system(size: 50))
                .frame(width: 70)
                
                TextField("Titel eingeben:", text: $title)
                    .font(.headline)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                
                Spacer()
            }
            .padding()
            
            TextEditor(text: $bodyText)
                .font(.body)
                .padding()
                .background(Color(.systemGray6))
                //.shadow(color: .gray, radius: 5)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                .frame(minHeight: 200)
                .padding()
            
            Spacer()
            
            Button(action: {
                showingSheet.toggle()
                addEntry()
            }) {
                Text("Speichern")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            }
            .padding(.horizontal)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 4))
        .padding()
        
    }
    
    //MARK: - Funktion zum HInzufügen
    private func addEntry() {
        let mood = Mood(id: UUID(), title: title, bodyText: bodyText, emoji: selectedEmoji.emoji)
        context.insert(mood)
    }
}


/*
 #Preview {
 AddEntryView()
 }
 */
