//
//  RootTabView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            MCQQuizView()
                .tabItem {
                    Label("MCQs", systemImage: "list.bullet.rectangle")
                }
            
            NumericQuizView()
                .tabItem {
                    Label("Numberical", systemImage: "number.square")
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
}
