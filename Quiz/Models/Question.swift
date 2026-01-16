//
//  Question.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import Foundation

enum QuestionType {
    case mcq
    case numeric
}

struct Question: Identifiable {
    let id = UUID()
    let type: QuestionType
    let prompt: String

    let options: [String]
    let correctIndex: Int?

    let correctNumber: Double?

    static func mcq(_ prompt: String, options: [String], correctIndex: Int) -> Question {
        Question(type: .mcq, prompt: prompt, options: options, correctIndex: correctIndex, correctNumber: nil)
    }

    static func numeric(_ prompt: String, correctNumber: Double) -> Question {
        Question(type: .numeric, prompt: prompt, options: [], correctIndex: nil, correctNumber: correctNumber)
    }
}
