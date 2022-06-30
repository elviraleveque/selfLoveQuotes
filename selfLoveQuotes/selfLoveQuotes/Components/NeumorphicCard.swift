//
//  NeumorphicCard.swift
//  NeumorphicAsyncButton
//
//  Created by Elvira Leveque on 31/03/22.
//

import SwiftUI

struct NeumorphicCard: View {
    @Binding var quote: String
    @Binding var opacity: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Self-love quote")
                .fontWeight(.semibold)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(quote)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .opacity(opacity)
            Spacer()
        }
        .frame(height: 200)
        .NeumorphicStyle()
    }
}
