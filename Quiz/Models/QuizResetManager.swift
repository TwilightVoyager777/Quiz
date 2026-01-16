//
//  QuizResetManager.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class QuizResetManager: ObservableObject {
    @Published var resetID: UUID = UUID()

    func triggerReset() {
        resetID = UUID()
    }
}
