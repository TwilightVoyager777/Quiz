//
//  RootTabView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var score: Score
    @EnvironmentObject private var store: NumericQuestionStore
    @EnvironmentObject private var resetManager: QuizResetManager
    var body: some View {
        TabView {
            MCQQuizView()
                .tabItem {
                    Label("MCQs", systemImage: "list.bullet.rectangle")
                }
            
            NumericQuizView()
                .tabItem {
                    Label("Numerical", systemImage: "number.square")
                }
            
            NumericQuestionEditorView()
                .tabItem {
                    Label("Edit", systemImage: "slider.horizontal.3")
                }
            
            ScoreView()
                .tabItem {
                    Label("Score", systemImage: "chart.bar.fill")
                }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(Score.shared)
        .environmentObject(NumericQuestionStore())
        .environmentObject(QuizResetManager())
}
