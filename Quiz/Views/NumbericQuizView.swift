//
//  NumbericQuizView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct NumericQuizView: View {
    @EnvironmentObject private var score: Score

//    private let questions = QuizData.numericQuestions Exercise1did
    @EnvironmentObject private var store: NumericQuestionStore
    @EnvironmentObject private var resetManager: QuizResetManager
    @State private var index: Int = 0

    @State private var input: String = ""
    @State private var hasSubmittedForCurrent: Bool = false
    @State private var lastResultIsCorrect: Bool? = nil

    @FocusState private var isFocused: Bool
//
//    private var current: Question { questions[index] }
//    private var isLastQuestion: Bool { index >= questions.count - 1 }

    private var questions: [Question] { store.questions }
    private var current: Question? {
        guard !questions.isEmpty, index >= 0, index < questions.count else { return nil }
        return questions[index]
    }
    
//    private var canSubmit: Bool {
//        guard score.canSubmit(questionID: current.id), !hasSubmittedForCurrent else { return false }
//        return parseNumber(input) != nil
//    }

    private var canSubmit: Bool {
            guard let q = current else { return false }
            guard score.canSubmit(questionID: q.id), !hasSubmittedForCurrent else { return false }
            return Double(input) != nil
        }
    
//    private var canGoNext: Bool {
//        !isLastQuestion
//    }

    private var canGoNext: Bool {
            guard !questions.isEmpty else { return false }
            return index < questions.count - 1
        }
    
    var body: some View {
        VStack(spacing: 18) {
            Text("Numerical Fill-in-the-Blank")
                .font(.title2).bold()
            
            if let q = current {
                Text(q.prompt)
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
                        guard let userValue = Double(input),
                              let correctValue = q.correctNumber
                        else { return }
                        let correct = userValue == correctValue
                        
                        score.recordAnswer(questionID: q.id, isCorrect: correct)
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
            } else {
                Text("No numerical questions available.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: store.questions.count) { _ in
            if store.questions.isEmpty {
                index = 0
                input = ""
                hasSubmittedForCurrent = false
                lastResultIsCorrect = nil
                isFocused = false
                return
            }
            
            if index >= store.questions.count {
                index = max(store.questions.count - 1, 0)
                input = ""
                hasSubmittedForCurrent = false
                lastResultIsCorrect = nil
                isFocused = false
            }
        }
        
        // When exiting edit mode, the editor triggers a global reset.
        .onChange(of: resetManager.resetID) { _ in
            index = 0
            input = ""
            hasSubmittedForCurrent = false
            lastResultIsCorrect = nil
            isFocused = false
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
        .environmentObject(NumericQuestionStore())
        .environmentObject(QuizResetManager())

}
