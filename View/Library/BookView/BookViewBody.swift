//
//  BookViewBody.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewBody: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var rectangleSize: [CGFloat]
    
    var body: some View {
        VStack {
            HStack {
                Text("About")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.theme.text)
                VStack{
                    Divider()
                }
            } //: HSTACK
            .padding([.leading, .top], 30)
            
            ScrollView {
                Text("\(libraryVM.selectedBook.about)")
                    .foregroundColor(Color.theme.text)
                .padding(30)
            }
        }
    }
}

struct BookViewBody_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(libraryVM: LibraryViewModel())
    }
}
