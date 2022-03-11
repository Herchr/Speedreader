//
//  BookView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 13/02/2022.
//

import SwiftUI

struct BookView: View {
    var bookTitle: String = ""
    var bookImg: UIImage?
    var body: some View {
        if let img = UIImage(named: bookTitle){
            Image(uiImage: img)
                .resizable()
                .frame(width: screen.height*0.15, height: screen.height*0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(6)
        }else{
            ZStack {
                if let img = bookImg{
                    Image(uiImage: img)
                        .resizable()
                        .frame(width: screen.height*0.15, height: screen.height*0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(6)
                    ZStack{
                        Color(red: 255/255, green: 250/255, blue: 240/255)
                            .overlay(Rectangle().frame(width: 0.3, height: nil, alignment: .trailing).foregroundColor(Color.gray), alignment: .trailing)
                            .overlay(Rectangle().frame(width: 0.3, height: nil, alignment: .leading).foregroundColor(Color.gray), alignment: .leading)

                        Text("\(bookTitle)")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 18))
                            .bold()
                            .foregroundColor(Color.theme.text)
                    }
                    .frame(width: screen.height*0.15, height: screen.height*0.1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 40)
                }
                
            }

        }
            
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(bookTitle: bookExamples[0].title, bookImg: bookExamples[0].img)
    }
}
