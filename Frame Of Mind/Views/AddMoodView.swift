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
    var selectedDate: Date
    private var bgColor: Color {
        return Moods(rawValue: selectedButton)?.bgColor ?? .clear
    }
    
    @State private var selectedButton: String = "happy"
    @State private var bodyText: String = ""
    @State private var date: Date = Date()
    @State private var showErrorAlert = false
    
    
    //MARK: - Emotion auswählen
    
    var body: some View {
        //MARK: - Background
        ZStack(alignment: .bottomTrailing) {
            Color.white.ignoresSafeArea()
            Circle().foregroundStyle(bgColor)
                .frame(maxWidth: 350, maxHeight: 350)
                .blur(radius: 150)
                .offset(x: 120, y: 120)
                .animation(.easeInOut(duration: 0.5), value: selectedButton)
            
            //MARK: - Titel
            VStack {
                topTitle // Titel anzeigen
                    .padding(.leading, 8)
                    .padding(.top, -40)
                Spacer()
                    .frame(maxHeight: 30)
                
                //MARK: - Emojiliste anzeigen
                moodSelection
                
                Text(moodButton(for: selectedButton))
                    .font(.headline)
                    .foregroundStyle(.black.opacity(0.6))
                    .padding(.top, 9)
                
                //MARK: - TextEditor
                TextEditor(text: $bodyText)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .padding()
                    .frame(maxWidth: 400, maxHeight: 400)
                
                //MARK: - Button
                Button(action: { //Button zum Speichern eines neuen Eintrages
                    addEntry()
                }) {
                    Text("Speichern")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color.clear)
                        .foregroundStyle(.black)
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
                    .foregroundStyle(.black)
                    .contentTransition(.numericText())
            }
        }
        .foregroundStyle(.black)
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
    
    //MARK: - Datum und Uhrzeit kombinieren um 
    private func combine(date: Date, with time: Date) -> Date {
        let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
            
            var combinedComponents = DateComponents()
            combinedComponents.year = dateComponents.year
            combinedComponents.month = dateComponents.month
            combinedComponents.day = dateComponents.day
            combinedComponents.hour = timeComponents.hour
            combinedComponents.minute = timeComponents.minute
            combinedComponents.second = timeComponents.second
            
            return calendar.date(from: combinedComponents) ?? date
    }
    
    //MARK: - Funktionen zum Hinzufügen eines Eintrags
    private func addEntry() {
        let currentDate = Date() // aktuelles Datum mit Uhrzeit
        let endDate = combine(date: selectedDate, with: currentDate)
        
        let mood = Mood(id: UUID(), title: moodTitle(for: selectedButton), bodyText: bodyText, emoji: Moods(rawValue: selectedButton)?.emoji ?? "", date: endDate)
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
        AddMoodView(selectedDate: Date())
            .modelContainer(DataManager.previewContainer)
    }
