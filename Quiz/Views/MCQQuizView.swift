//
//  MCQQuizView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct MCQQuizView: View {
    // MARK: -Properties
    @EnvironmentObject private var score: Score

    private let questions = QuizData.mcqQuestions
    @State private var index: Int = 0

    @State private var selection: Int = 0
    @State private var hasSubmittedForCurrent: Bool = false
    @State private var lastResultIsCorrect: Bool? = nil

    private var current: Question { questions[index] }
    private var isLastQuestion: Bool { index >= questions.count - 1 }

    private var canSubmit: Bool {
        score.canSubmit(questionID: current.id) && !hasSubmittedForCurrent
    }

    private var canGoNext: Bool {
        !isLastQuestion
    }

    
    // MARK: -Body
    var body: some View {
        VStack(spacing: 18) {
            Text("Multiple Choice")
                .font(.title2).bold()

            Text(current.prompt)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            //Picker 替代 UIPickerView
            Picker("Answer", selection: $selection) {
                ForEach(0..<current.options.count, id: \.self) { i in
                    Text(current.options[i]).tag(i)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 160)

            if let result = lastResultIsCorrect {
                Text(result ? "Corret" : "Incorrect")
                    .font(.system(size: 42, weight: .heavy))
                    .foregroundStyle(result ? .green : .red)
                    .padding(.top, 6)
            }

            HStack(spacing: 12) {
                Button("Submit Answer") {
                    let correct = (selection == current.correctIndex)
                    score.recordAnswer(questionID: current.id, isCorrect: correct)
                    hasSubmittedForCurrent = true
                    lastResultIsCorrect = correct
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canSubmit)

                Button("Next Question") {
                    guard canGoNext else { return }
                    index += 1

                    selection = 0
                    hasSubmittedForCurrent = false
                    lastResultIsCorrect = nil
                }
                .buttonStyle(.bordered)
                .disabled(!canGoNext)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            if !score.canSubmit(questionID: current.id) {
                hasSubmittedForCurrent = true
            }
        }
    }
}


#Preview {
    MCQQuizView()
        .environmentObject(Score.shared)

}
