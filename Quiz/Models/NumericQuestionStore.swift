//
//  NumericQuestionStore.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class NumericQuestionStore: ObservableObject {
    @Published var questions: [Question]

    init() {
        self.questions = [
            .numeric("If you push 3 elements onto an empty stack, how many elements are in the stack?3", correctNumber: 3),
            .numeric("If an array has indices from 0 to 4, how many elements does it contain?5", correctNumber: 5),
            .numeric("If you enqueue 5 items into a queue and dequeue 2 items, how many items remain?3", correctNumber: 3),

            .numeric("A linked list has 4 nodes. If you delete 1 node, how many nodes remain?3", correctNumber: 3),
            .numeric("A binary tree with only 1 root node has how many nodes?1", correctNumber: 1),
            .numeric("If you add 2 new items to a list that currently has 6 items, how many items now?8", correctNumber: 8)
        ]
    }

    func delete(at offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        questions.move(fromOffsets: source, toOffset: destination)
    }
    //source yi destnation
}
