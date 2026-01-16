//
//  QuizApp.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/6.
//

import SwiftUI

@main
struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(Score.shared)
        }
    }
}
