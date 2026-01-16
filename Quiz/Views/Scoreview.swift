//
//  Scoreview.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject private var score: Score

    private var bg: Color {
        if score.correct > score.incorrect { return .green.opacity(0.25) }
        if score.incorrect > score.correct { return .red.opacity(0.25) }
        return .white
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Score")
                .font(.largeTitle).bold()

            Text("Correct: \(score.correct)")
                .font(.title2)

            Text("Incorrect: \(score.incorrect)")
                .font(.title2)

            Button("Reset Score") {
                score.resetAll()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bg)
    }
}

#Preview {
    ScoreView()
        .environmentObject(Score.shared)

}
