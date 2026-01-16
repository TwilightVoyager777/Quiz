//
//  NumbericQuizView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct NumericQuizView: View {
    @EnvironmentObject private var score: Score

    private let questions = QuizData.numericQuestions
    @State private var index: Int = 0

    @State private var input: String = ""
    @State private var hasSubmittedForCurrent: Bool = false
    @State private var lastResultIsCorrect: Bool? = nil

    @FocusState private var isFocused: Bool

    private var current: Question { questions[index] }
    private var isLastQuestion: Bool { index >= questions.count - 1 }

    private var canSubmit: Bool {
        guard score.canSubmit(questionID: current.id), !hasSubmittedForCurrent else { return false }
        return parseNumber(input) != nil
    }

    private var canGoNext: Bool {
        !isLastQuestion
    }

    var body: some View {
        VStack(spacing: 18) {
            Text("Numerical Fill-in-the-Blank")
                .font(.title2).bold()

            Text(current.prompt)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            TextField(
                "",
                text: Binding(
                    get: { input },
                    set: { input = sanitizeNumericInput($0) }
                ),
                prompt: Text("Enter a number (e.g., 2.5)")
            )
            .keyboardType(.decimalPad)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .textFieldStyle(.roundedBorder)
            .focused($isFocused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { isFocused = false }
                }
            }

            if let result = lastResultIsCorrect {
                Text(result ? "Correct" : "Incorrect")
                    .font(.system(size: 42, weight: .heavy))
                    .foregroundStyle(result ? .green : .red)
                    .padding(.top, 6)
            }

            HStack(spacing: 12) {
                Button("Submit Answer") {
                    guard let userValue = parseNumber(input),
                          let correctValue = current.correctNumber
                    else { return }
                    let correct = userValue == correctValue

                    score.recordAnswer(questionID: current.id, isCorrect: correct)
                    hasSubmittedForCurrent = true
                    lastResultIsCorrect = correct
                    isFocused = false
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canSubmit)

                Button("Next Question") {
                    guard canGoNext else { return }
                    index += 1

                    input = ""
                    hasSubmittedForCurrent = false
                    lastResultIsCorrect = nil
                    isFocused = false
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

    private func sanitizeNumericInput(_ raw: String) -> String {
        var s = raw.filter { "0123456789.-".contains($0) }

        if let firstDash = s.firstIndex(of: "-"), firstDash != s.startIndex {
            s.remove(at: firstDash)
        }
        if s.filter({ $0 == "." }).count > 1 {
            if let lastDot = s.lastIndex(of: ".") {
                s.remove(at: lastDot)
            }
        }
        return s
    }

    private func parseNumber(_ s: String) -> Double? {
        Double(s)
    }
}


#Preview {
    NumericQuizView()
        .environmentObject(Score.shared)

}
