//
//  QuizApp.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/6.
//

import SwiftUI

@main
struct QuizApp: App {
    @StateObject private var store = NumericQuestionStore()
    @StateObject private var resetManager = QuizResetManager()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(Score.shared)
                .environmentObject(store)
                .environmentObject(resetManager)
        }
    }
}
