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
    
}

struct ColorTheme {
    
    let primary = Color("PrimaryColor")
    let secondary = Color("SecondaryColor")
    let accent = Color("AccentColor")
    let accentGradient = Color("AccentGradientColor")
    let text = Color("TextColor")
    
}
