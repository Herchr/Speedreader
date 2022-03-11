//
//  Color.swift
//  Speedreader
//
//  Created by Herman Christiansen on 09/10/2021.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
    
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

struct ColorTheme {
    
    let primary = Color("PrimaryColor")
    let primaryDark = Color("PrimaryDarkColor")
    let background = Color("BGColor")
    let accent = Color("AccentColor")
    let accentGradient = Color("AccentGradientColor")
    let text = Color("TextColor")
    let redGradient1 = Color("RedGradient1")
    let pinkGradient = Color("PinkGradient")
    
}

//extension Color {
//    static let neuBackground = Color(hex: "f0f0f3")
//    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
//    static let dropLight = Color(hex: "ffffff")
//}

//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//
//        let r = (rgbValue & 0xff0000) >> 16
//        let g = (rgbValue & 0xff00) >> 8
//        let b = rgbValue & 0xff
//
//        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
//    }
//}
