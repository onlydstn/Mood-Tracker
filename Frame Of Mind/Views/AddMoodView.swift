//
//  AddMoodView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import SwiftUI
import SwiftData

struct AddMoodView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) private var dissmissAddMoodView
    
    let moodButton = ["happy", "sad", "angry", "excited", "tired", "bored"]
    
    @State private var selectedButton: String = "happy"
    @State private var selectedEmoji: Moods = .happy
    @State private var bodyText: String = ""
    @State private var date: Date = Date()
    
    
    //MARK: - Body View
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()
            Circle().foregroundStyle(.white)
                .frame(maxWidth: 350, maxHeight: 350)
                .blur(radius: 180)
                .offset(x: 150, y: 150)
            VStack {
                topTitle // Titel anzeigen
                    .padding(.leading, 8)
                    .padding(.top, -40)
                Spacer()
                    .frame(maxHeight: 30)
                
                moodSelection // Emojiliste anzeigen
                
                Text(moodButton(for: selectedButton))
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.6))
                    .padding(.top, 9)
                
                TextEditor(text: $bodyText)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .padding()
                    .frame(maxWidth: 400, maxHeight: 400)
                
                Button(action: { //Button zum Speichern eines neuen Eintrages
                    addEntry()
                }) {
                    Text("Speichern")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color.clear)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        .padding()
                }
                
                Spacer()
            }
        }
    }
    
    //MARK: - TitelView
    
    var topTitle: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Wie fühlst du")
            HStack {
                Text("dich Heute?")
                    .foregroundStyle(.white)
                    .contentTransition(.numericText())
            }
        }
        .foregroundStyle(.white)
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Emojiansicht View
    
    var moodSelection: some View {
        HStack(spacing: 16) {
            ForEach(moodButton, id: \.self) { button in
                Button(action: {
                    selectedButton = button
                }) {
                    Image(button)
                        .resizable()
                        .scaledToFit()
                        .frame(width: selectedButton == button ? 80 : 40, height: selectedButton == button ? 80 : 40)
                        .opacity(selectedButton == button ? 1.0 : 0.33)
                        .animation(.easeInOut(duration: 0.25), value: selectedButton)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    //MARK: - Funktionen zum Hinzufügen eines Eintrags
    
    private func addEntry() {
        let mood = Mood(id: UUID(), title: moodTitle(for: selectedButton), bodyText: bodyText, emoji: Moods(rawValue: selectedButton)?.emoji ?? "")
        context.insert(mood)
        dissmissAddMoodView.wrappedValue.dismiss()
    }
    
    //MARK: - Funktion um Beschriftung unter dem Emoji-Button zu ändern
    
    private func moodButton(for button: String) -> String {
        switch button {
        case "happy":
            return "Glücklich"
        case "sad":
            return "Traurig"
        case "angry":
            return "Sauer"
        case "excited":
            return "Aufgeregt"
        case "tired":
            return "Müde"
        case "bored":
            return "Gelangweilt"
        default:
            return ""
        }
    }
    
    //MARK: - Funktion um Eintragüberschrift festzulegen
    
    private func moodTitle(for button: String) -> String {
        switch button {
        case "happy":
            return "ein glücklicher Eintrag"
        case "sad":
            return "ein trauriger Eintrag"
        case "angry":
            return "ich bin sauer!"
        case "excited":
            return "ich bin aufgeregt!"
        case "tired":
            return "einfach nur müde..."
        case "bored":
            return "passiert eigentlich noch was?"
        default:
            return ""
        }
    }
}

#Preview {
    AddMoodView()
        .modelContainer(DataManager.previewContainer)
}
