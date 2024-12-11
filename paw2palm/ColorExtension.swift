//
//  ColorExtension.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/11/24.
//

import Foundation
import SwiftUI

//article: https://medium.com/@jakir/use-hex-color-in-swiftui-c19e6ab79220
extension Color {
    static let lightPink = Color(hex: 0xea88b9)
    static let niceBlue = Color(hex: 0x8888ea)
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
