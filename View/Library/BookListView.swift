//
//  BookView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 08/09/2021.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var animation: Namespace.ID
    var rows: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 1)
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                Color.white
                    .frame(width: UIScreen.main.bounds.width - 30, height: 280)
                    .opacity(0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing:0) {
                    if let filteredBooks = libraryVM.filteredBooks{
                        ForEach(filteredBooks, id: \.self.id){ book in
                            VStack(alignment: .leading, spacing: 10){
                                if let img = book.img{
                                    Image(uiImage: img)
                                        .resizable()
                                        .frame(width: 130, height: 177, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(6)
                                        .matchedGeometryEffect(id: book.title, in: animation)
                                }
                                Text("\(book.title)")
                                    .foregroundColor(Color.theme.text)
                                    .fontWeight(.semibold)
                                    .frame(width: 130, height: 20, alignment: .topLeading)
                            }
                            .onTapGesture{
                                withAnimation{
                                    libraryVM.selectedBook = book
                                    libraryVM.showBookView.toggle()
                                }
                            }
                            .padding(.trailing,20)
                        } //: FOREACH
                    }
                } //: LAZYHGRID
                .padding(.leading, 20)
            } //: SCROLLVIEW
            .padding(.leading, 32)
            //.headerPadding()
        } //: ZSTACK
    }
}

struct BookListView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        BookListView(animation: animation)
            .environmentObject(LibraryViewModel())
    }
}
