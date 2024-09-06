//
//  Mood.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import Foundation
import SwiftData

@Model
class Mood: Identifiable {
    let id = UUID()
    
    var title: String
    var bodyText: String
    var emoji: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, bodyText: String, emoji: String, date: Date) {
        self.id = id
        self.title = title
        self.bodyText = bodyText
        self.emoji = emoji
        self.date = date
    }
    
    // enum Moods zurückgeben um basierend auf Emoji Farbe der bordercolor zu ändern
    var moodType: Moods {
        switch emoji {
        case "😊": return .happy
        case "😢": return .sad
        case "😡": return .angry
        case "🤩": return .excited
        case "😴": return .tired
        case "😐": return .bored
        default: return .happy
        }
    }
}
