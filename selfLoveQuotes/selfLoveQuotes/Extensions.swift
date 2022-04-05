//
//  Extensions.swift
//  NeumorphicAsyncButton
//
//  Created by Elvira Leveque on 31/03/22.
//

import SwiftUI

// create the offWhite color
extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}



// set a default linear gradient
extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}



// create our neumorphic style
extension View {
    func NeumorphicStyle() -> some View {
        self.padding(30)
            .frame(maxWidth: 400)
            .background(Color.offWhite)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}
