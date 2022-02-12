//
//  GenreIcon.swift
//  Speedreader
//
//  Created by Herman Christiansen on 12/02/2022.
//

import SwiftUI

struct GenreIcon: View {
    var iconName: String
    var body: some View {
        ZStack{
            
            HStack{
                Image("\(iconName)")
                    .resizable()
                    .frame(width: 34, height: 34)
                Text("\(iconName)")
                    .font(Font.title3.bold())
            }
            .padding()
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.white)
                    //.shadow(radius: 10, x: 5, y: 5)
            )
            .background(
                HStack{
                    Circle()
                        .fill(Color("\(iconName)"))
                        .blur(radius: 7)
                        .frame(width: 34, height: 34)
                    Spacer()
                }
                    .padding(.top, 44)
                    .padding(.leading, 21)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.linearGradient(colors: [.white, .black.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .blendMode(.overlay)
            )
        }
    }
}

struct GenreIcon_Previews: PreviewProvider {
    static var previews: some View {
        GenreIcon(iconName: "Romance")
    }
}
