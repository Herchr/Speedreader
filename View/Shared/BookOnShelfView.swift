//
//  BookOnShelfView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 21/04/2022.
//

import SwiftUI
import Lottie

struct BookOnShelfView: View {
    var bookTitle: String
    var bookImg: UIImage?
    var body: some View {
        ZStack {
            Image("BookShelf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 280)
                .offset(y: screen.height*0.11)
            ZStack(alignment: .trailing){
                Rectangle()
                    .frame(width: 45)
                    .rotationEffect(Angle(degrees: -5))
                    .rotation3DEffect(Angle(degrees: 50), axis: (0,1,0))
                    .mask(
                        LinearGradient(colors: [.black.opacity(0.6), .black.opacity(0.1)], startPoint: .leading, endPoint: .trailing)
                            
                    )
                    .blur(radius: 2)
                    .padding(.top, 4)
                    .offset(x: 20)
                BookView(bookTitle: bookTitle, bookImg: bookImg)
            }
            .fixedSize()
           
        }
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .frame(width: 200, height: screen.height*0.25)
                .foregroundStyle(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(.linearGradient(colors: [.white.opacity(0.8),  .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                        .blendMode(.overlay)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(.linearGradient(colors: [.gray.opacity(0.4), .clear], startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 0.5)
                )
        )
        .padding()
    }
}

struct BookOnShelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookOnShelfView(bookTitle: "Siddhartha")
    }
}
