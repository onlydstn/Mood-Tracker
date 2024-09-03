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
    var date: Date = Date()
    
    init(id: UUID = UUID(), title: String, bodyText: String, emoji: String) {
        self.id = id
        self.title = title
        self.bodyText = bodyText
        self.emoji = emoji
    }
}
