//
//  QuizData.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import Foundation

enum QuizData {
    static let mcqQuestions: [Question] = [
        .mcq(
            "Which data structure follows the FIFO (First In, First Out) principle?",
            options: ["Stack", "Queue✅", "Array", "Tree"],
            correctIndex: 1
        ),
        .mcq(
            "Which data structure follows the LIFO (Last In, First Out) principle?",
            options: ["Queue", "Array", "Stack✅", "Heap"],
            correctIndex: 2
        ),
        .mcq(
            "Which data structure is typically used to store key-value pairs?",
            options: ["Array", "Stack", "Queue", "Hash Table✅"],
            correctIndex: 3
        )
    ]


    static let numericQuestions: [Question] = [
        .numeric(
            "If you push 3 elements onto an empty stack, how many elements are in the stack?3✅",
            correctNumber: 3
        ),
        .numeric(
            "If an array has indices from 0 to 4, how many elements does it contain?5✅",
            correctNumber: 5
        ),
        .numeric(
            "If you enqueue 5 items into a queue and dequeue 2 items, how many items remain?3✅",
            correctNumber: 3
        )
    ]

}
