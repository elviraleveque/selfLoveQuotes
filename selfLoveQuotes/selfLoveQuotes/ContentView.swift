//
//  ContentView.swift
//  NeumorphicAsyncButton
//
//  Created by Elvira Leveque on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    @State private var quote: String = "You yourself, as much as anybody in the entire universe, deserve your love and affection."
    @State private var opacity: Double = 1
    
    @StateObject private var quotesVM = QuotesViewModel()
    @State private var index: Int = 0
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            
            Image("heart")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            NeumorphicCard(quote: $quote, opacity: $opacity)
            
            NeumorphicAsyncButton(
                action: {
                    try await quotesVM.randomQuoteGenerator(with: quotesVM.quotes, and: index)
                    
                },
                text: "New quote",
                icon: "quote.bubble.fill",
                quote: $quote,
                opacity: $opacity, index: $index
                
            )

            
            Spacer()

        }
        .padding(.vertical)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offWhite)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
