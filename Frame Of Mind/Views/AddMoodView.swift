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
    let moodButton = ["happy", "sad", "angry", "excited", "tired", "bored"]
    
    @State private var selectedButton: String = "happy"
    @State private var selectedEmoji: Moods = .happy
    @State private var title: String = ""
    @State private var bodyText: String = ""
    @State private var date: Date = Date()
    
    //@Binding var showingSheet: Bool
    
    //MARK: - body view
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()
            Circle().foregroundStyle(.white)
                .frame(maxWidth: 300, maxHeight: 300)
                .blur(radius: 180)
                .offset(x: 130, y: 130)
            VStack {
                topTitle
                    .padding(.leading, 8)
                Spacer()
                    .frame(maxHeight: 50)
                
                moodSelection
                
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
                
                Button(action: {
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
    
    //MARK: - EmojiPicker View
    var moodSelection: some View {
            HStack(spacing: 16) {
                ForEach(moodButton, id: \.self) { button in
                    Button(action: {
                        //showingSheet.toggle()
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
    //MARK: - Funktionen
    
    private func addEntry() {
        let mood = Mood(id: UUID(), title: title, bodyText: bodyText, emoji: selectedButton)
        context.insert(mood)
    }
    
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
}
    
    //#Preview {
       // AddMoodView()
   // }
