//
//  DetailView.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftUI

struct DetailView: View {
    var mood: Mood
    
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
            
            Text(mood.bodyText)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            /*
            Button(action: {
                // Aktion des Buttons
            }) {
                Text("Eintrag bearbeiten")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .padding()
            }
             */
        }
    }
}
