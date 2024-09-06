//
//  DataManager.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 02.09.24.
//

import SwiftData
import Foundation

class DataManager {
    static let container: ModelContainer = {
        do {
            return try ModelContainer(for: Mood.self)
        } catch {
            fatalError("Failed to configure SwiftData")
        }
    }()
    
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Mood.self, configurations: config)
            
            for number in 1...1 {
                let mood = Mood(title: "Testtitel", bodyText: "Das ist ein Testtext für den Inhalt", emoji: "😃", date: Date())
                container.mainContext.insert(mood)
            }
            
            return container
        } catch {
            fatalError("Failed to configure SwiftData")
        }
    }()
}
