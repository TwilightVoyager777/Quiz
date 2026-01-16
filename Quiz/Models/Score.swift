//
//  Score.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class Score: ObservableObject {
    static let shared = Score()
    private init() {}

    @Published private(set) var correct: Int = 0
    @Published private(set) var incorrect: Int = 0

    private var answeredQuestionIDs: Set<UUID> = []

    func canSubmit(questionID: UUID) -> Bool {
        !answeredQuestionIDs.contains(questionID)
    }

    func recordAnswer(questionID: UUID, isCorrect: Bool) {
        guard !answeredQuestionIDs.contains(questionID) else { return }
        answeredQuestionIDs.insert(questionID)

        if isCorrect { correct += 1 }
        else { incorrect += 1 }
    }

    func resetAll() {
        correct = 0
        incorrect = 0
        answeredQuestionIDs.removeAll()
    }
}

