//
//  AsyncButton.swift
//  NeumorphicAsyncButton
//
//  Created by Elvira Leveque on 31/03/22.
//

import Foundation
import SwiftUI

struct NeumorphicAsyncButton: View {
    var action: () async throws -> Int
    
    var text: String
    var icon: String
    
    @State private var isPerformingTask = false
    @State private var isCompleted = false
    
    // quote text properties
    @Binding var quote: String
    @Binding var opacity: Double
    @Binding var index: Int
    
    @StateObject private var quotesVM = QuotesViewModel()
    
    var body: some View {
        Button(
            action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    isPerformingTask = true
                }
                
                // Animate the opacity of the quote text in the content view screen
                withAnimation(.easeInOut(duration: 1.5)) {
                    opacity = 0
                }
                
                Task {
                    index = try await quotesVM.randomQuoteGenerator(with: quotesVM.quotes, and: index)
                    quote = quotesVM.quotes[index]
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isPerformingTask = false
                        isCompleted = true
                    }
                    
                    // animate the opacity of the quote text back
                    withAnimation(.easeInOut(duration: 1)) {
                        opacity = 1
                    }
                    
                    // Go back to initial state
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            isCompleted = false
                        }
                    }
                }
            },
            
            label: {
                HStack(spacing: 20) {
                    if !isPerformingTask && !isCompleted {
                        Text(text.uppercased())
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    if isPerformingTask && !isCompleted{
                        DotProgressView()
                    }
                }
                .foregroundColor(isCompleted ? Color.pink : Color.gray)
                .opacity(isPerformingTask ? 0.5 : 1)
                .padding(.horizontal, isCompleted && !isPerformingTask ? 0 : 15)
            })
        .buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 20)))
        .disabled(isPerformingTask || isCompleted)
    }
}
