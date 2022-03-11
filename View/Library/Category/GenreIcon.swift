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
                if iconName != "All"{
                    Image("\(iconName)")
                        .resizable()
                        .frame(width: screen.height*0.04, height: screen.height*0.04)
                }
                Text("\(iconName)")
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .padding(.horizontal, iconName == "All" ? 30 : 0)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, screen.height*0.008)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.white)
                    //.shadow(radius: 10, x: 5, y: 5)
            )
            .background(
                HStack{
                    Circle()
                        .fill(Color("\(iconName)"))
                        .blur(radius: 6)
                        .opacity(0.3)
                        .frame(width: screen.height*0.06, height: screen.height*0.055)
                    Spacer()
                }
                    .padding(.top, screen.height*0.030)
                    .padding(.leading, 6)
            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                    .stroke(lineWidth: 2)
//                    .foregroundStyle(.linearGradient(colors: [.white, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .blendMode(.overlay)
//            )
        }
    }
}

struct GenreIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreIcon(iconName: "Romance")
//    }
    static var previews: some View {
        CategoriesView()
            .environmentObject(LibraryViewModel())
    }
}
