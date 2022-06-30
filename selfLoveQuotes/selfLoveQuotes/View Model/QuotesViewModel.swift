//
//  QuotesViewModel.swift
//  selfLoveQuotes
//
//  Created by Elvira Leveque on 23/06/22.
//

import Foundation

class QuotesViewModel: ObservableObject {
    @Published var quotes: [String] = ["You yourself, as much as anybody in the entire universe, deserve your love and affection.",
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
    
    // async function
    func randomQuoteGenerator(with array: [String], and integer: Int) async throws
    -> Int {
        var randomInt = integer
        
        while integer == randomInt {
            randomInt = Int.random(in: 0..<array.count)
        }
        
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)  // Three seconds
        return randomInt
    }
}
