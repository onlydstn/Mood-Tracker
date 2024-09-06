//
//  DetailView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI

struct DetailView: View {
    var mood: Mood
    
    //MARK: - Detailansicht nach tap auf einen Listeneintrag
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(mood.emoji)
                    .font(.system(size: 50))
                
                VStack(alignment: .leading) {
                    Text(mood.title)
                        .font(.headline)
                    Text(mood.date.formatted())
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            .padding()
            Divider()
                .padding(.top, -25)
            
            Text(mood.bodyText)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
    }
}

#Preview {
    DetailView(mood: Mood(id: UUID(), title: "Testtitel", bodyText: "Das ist ein Testtext", emoji: "😃", date: Date()))
        .modelContainer(DataManager.previewContainer)
}
