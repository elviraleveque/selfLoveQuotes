//
//  AsyncButton.swift
//  NeumorphicAsyncButton
//
//  Created by Elvira Leveque on 31/03/22.
//

import Foundation
import SwiftUI

struct NeumorphicAsyncButton: View {
    var action: () async throws -> String
    
    var text: String
    var icon: String
    
    @State private var isPerformingTask = false
    @State private var isCompleted = false
    
// quote text properties
    @Binding var quote: String
    @Binding var opacity: Double
    
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
                    quote = try await action()
                    
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isPerformingTask = false
                        isCompleted = true
                    }
                    
                    // animate the opacity of the quote text back
                    withAnimation(.easeInOut(duration: 1)) {
                        opacity = 1
                    }
                    
                    print(quote)
                    
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

// async function
func action() async throws -> String{
    let quotes = ["You yourself, as much as anybody in the entire universe, deserve your love and affection.",
                  "You deserve someone who makes you feel like the otherworldly creature you are. Yourself.",
                  "Be so completely yourself that everyone else feels safe to be themselves, too.",
                  "Love yourself first and everything else falls into line. You really have to love yourself to get anything done in this world.",
                  "Gonna love myself. No, I don’t need anybody else",
                  "To love oneself is the beginning of a life-long romance.",
                  "You have to believe in yourself when no one else does – that makes you a winner right here.",
                  "They will try to make you unhappy, don’t let them. They will try to tell you you’re not free, don’t listen.",
                  "A person learns how to love himself through the simple acts of loving and being loved by someone else.",
                  "Find the love you seek, by first finding the love within yourself. Learn to rest in that place within you that is your true home."
    ]
    
    let index = Int.random(in: 0..<10)
    try await Task.sleep(nanoseconds: 3 * 1_000_000_000)  // Three seconds
    return quotes[index]
}

