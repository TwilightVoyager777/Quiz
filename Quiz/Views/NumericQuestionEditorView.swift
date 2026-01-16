//
//  NumericQuestionEditorView.swift
//  Quiz
//
//  Created by 橡皮擦 on 2026/1/15.
//

import SwiftUI

struct NumericQuestionEditorView: View {
    
    @EnvironmentObject private var store: NumericQuestionStore
    @EnvironmentObject private var score: Score
    @EnvironmentObject private var resetManager: QuizResetManager
    
    //    @Environment(\.editMode) private var editMode
    //    @State private var wasEditing: Bool = false
    @State private var isEditing: Bool = false

    private var editModeBinding: Binding<EditMode> {
        Binding(
            get: { isEditing ? .active : .inactive },
            set: { newValue in
                isEditing = (newValue == .active)
            }
        )
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.questions) { q in
                    NumericQuestionRow(question: q)
                }
                .onDelete(perform: store.delete)
                .onMove(perform: store.move)
            }
            .id(isEditing)
            .listStyle(.insetGrouped)
            .navigationTitle("Edit Numerical")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        if isEditing {
                            isEditing = false
                            score.resetAll()
                            resetManager.triggerReset()
                        } else {
                            isEditing = true
                        }
                    }
                }
            }
        }
        .environment(\.editMode, editModeBinding)
        .onDisappear {
            if isEditing {
                isEditing = false
                score.resetAll()
                resetManager.triggerReset()
            }
        }
    }
    //一开始点击不成立，点了done之后成立
    //        .onChange(of: editMode?.wrappedValue.isEditing ?? false) { isEditing in
    //            if wasEditing == true && isEditing == false {
    ////                score.resetAll()
    ////                resetManager.triggerReset()
    //                doFullReset(reason: "Done pressed (edit -> not edit)")
    //            }
    //            wasEditing = isEditing
    //        }.onDisappear {
    //            if wasEditing {
    ////                score.resetAll()
    ////                resetManager.triggerReset()
    //                doFullReset(reason: "Left tab while editing (onDisappear)")
    //                wasEditing = false
    //            }
    //        }
    
}




private struct NumericQuestionRow: View {
    let question: Question

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(question.prompt)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)

            Text("Answer: \(formatAnswer(question.correctNumber))")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }

    private func formatAnswer(_ value: Double?) -> String {
        guard let v = value else { return "" }
        if v == Double(Int(v)) { return String(Int(v)) }
        return String(v)
    }
}


#Preview {
    NumericQuestionEditorView()
        .environmentObject(Score.shared)
        .environmentObject(NumericQuestionStore())
        .environmentObject(QuizResetManager())
}
