//
//  MoodCases.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import Foundation

enum Moods: String, Identifiable, CaseIterable {
    case happy, sad, angry, excited, tired, bored
    
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .happy: "😊"
        case .sad: "😢"
        case .angry: "😡"
        case .excited: "🤩"
        case .tired: "😴"
        case .bored: "😐"
        }
    }
    
    var name: String {
        switch self {
        case .happy: "Glücklich"
        case .sad: "Traurig"
        case .angry: "Wütend"
        case .excited: "Aufgeregt"
        case .tired: "Müde"
        case .bored: "Gelangweilt"
            
        }
    }
}
