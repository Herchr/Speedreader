//
//  Icon.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/02/2022.
//

import SwiftUI

struct Icon: View {
    var iconName: String
    @Binding var isEditing: Bool
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .light) {
                ZStack{
                    if isEditing{
                        AngularGradient(gradient: Gradient(colors: [Color.theme.accent, Color.theme.accentGradient]), center: .center, angle: .degrees(0))
                            .blendMode(.overlay)
                            .blur(radius: 10)
                    }
                    
                    Color.white
                        .cornerRadius(12)
                        .opacity(0.8)
                        .blur(radius: 3)
                    
                    
                }
            }
            .cornerRadius(12)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(.white.opacity(0.7), lineWidth: 1)
                    .blendMode(.overlay)
                    LinearGradient(colors: [Color.black, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask(
                            Image(systemName: iconName)
                                .font(.system(size: 17, weight: .medium))
                        )
                    
                }
            )
        }
        .frame(width: 36, height: 36, alignment: .center)
        .shadow(radius: 5)
        .padding([.vertical, .leading], 8)
        
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(iconName: "envelope.open.fill", isEditing: Binding.constant(false))
    }
}
