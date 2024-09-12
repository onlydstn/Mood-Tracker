//
//  MoodListView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI

struct MoodListView: View {
    var mood: Mood
    @State private var isShowing = false
    
    //MARK: - Listeneintrag
    var body: some View {
        Button {
            isShowing.toggle()
        } label: {
            VStack {
                HStack {
                    Text(mood.emoji)
                        .font(.system(size: 50))
                    
                    VStack {
                        Text(mood.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(mood.date.formatted())
                            .font(.subheadline)
                            .foregroundStyle(.gray.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Text(mood.bodyText)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(mood.moodType.bgColor, lineWidth: 1))
            //.overlay(RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 0.3))
            .background(mood.moodType.bgColor.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .sheet(isPresented: $isShowing) {
            DetailView(mood: mood)
                .presentationDetents([.fraction(0.4), .height(490), .large])
        }
    }
}
/*
 #Preview {
 MoodListView(mood: Mood(title: "Testtitel", bodyText: "Das ist ein Testtext", emoji: "😃"))
 .modelContainer(DataManager.previewContainer)
 }
 */
