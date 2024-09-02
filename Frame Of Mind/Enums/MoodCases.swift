//
//  MoodCases.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import Foundation

enum Moods: String, Identifiable, CaseIterable {
    case 😃, 😞, 😡, 🤩, 😴, 🥱
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .😃: "😃"
        case .😞: "😞"
        case .😡: "😡"
        case .🤩: "🤩"
        case .😴: "😴"
        case .🥱: "🥱"
        }
    }
    
    var name: String {
        switch self {
        case .😃: "Glücklich"
        case .😞: "Trautig"
        case .😡: "Wütend"
        case .🤩: "Aufgeregt"
        case .😴: "Müde"
        case .🥱: "Gelangweilt"
            
        }
    }
}
