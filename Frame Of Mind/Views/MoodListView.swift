//
//  MoodListView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI

struct MoodListView: View {
    var mood: Mood
    
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
        .background(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.white)
        .shadow(color: .gray.opacity(0.35), radius: 15, x: 0, y: 0)
        .mask(RoundedRectangle(cornerRadius: 20).padding(.top, -10))
        .overlay(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)).fill(.clear).stroke(Color.gray, lineWidth: 0.25))
        .padding(.horizontal, 24)
    }
}


#Preview {
    MoodListView(mood: Mood(title: "Testtitel", bodyText: "Das ist ein Testtext", emoji: "😃"))
        .modelContainer(DataManager.previewContainer)
}
