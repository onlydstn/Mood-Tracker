//
//  MoodListView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI

struct MoodListView: View {
    var mood: Mood
    
    //MARK: - Listeneintrag
    var body: some View {
        VStack(alignment: .leading, spacing: -16) {
            HStack {
                Text(mood.emoji)
                    .font(.system(size: 50))
                
                VStack(alignment: .leading) {
                    Text(mood.title)
                        .font(.headline)
                    
                    Text(mood.date.formatted())
                        .font(.subheadline)
                        .foregroundStyle(.gray.opacity(0.8))
                }
                .foregroundStyle(Color.primary)
                Spacer()
            }
            .foregroundStyle(Color.primary)
            .padding()
            
            Text(mood.bodyText)
                .font(.body)
                .padding()
                .foregroundStyle(Color.primary)
        }
        .background(RoundedRectangle(cornerRadius: 15))
        .foregroundStyle(Color.white)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: -5)
        .mask(RoundedRectangle(cornerRadius: 15).padding(.bottom, -10))
        .overlay(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(mood.moodType.bgColor, lineWidth: 0.5))
        .padding(.horizontal, 24)
    }
}
/*
 #Preview {
 MoodListView(mood: Mood(title: "Testtitel", bodyText: "Das ist ein Testtext", emoji: "😃"))
 .modelContainer(DataManager.previewContainer)
 }
 */
