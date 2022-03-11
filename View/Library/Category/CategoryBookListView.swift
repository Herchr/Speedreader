//
//  CategoryBookListView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 13/02/2022.
//

import SwiftUI

struct CategoryBookListView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var iconName: String
    @Namespace var animation2
    
    var columns: [GridItem] = Array.init(repeating: GridItem(.flexible(), spacing: -40), count: 2)
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    withAnimation{
                        libraryVM.showCategoryBookListView = false
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                })
                Spacer()
            }
            .padding(.leading)
            HStack {
                Text("\(iconName) books")
                    .font(Font.largeTitle.bold())
                Spacer()
            }
            .padding(50)
            ScrollView{
                LazyVGrid(columns: columns){
                    if let books = libraryVM.filteredBooks{
                        ForEach(books){ book in
                            BookView(bookTitle: book.title, bookImg: book.img)
                                .padding(.bottom)
                                .onTapGesture{
                                    withAnimation{
                                        libraryVM.selectedBook = book
                                        libraryVM.showBookView.toggle()
                                    }
                                }
                                .matchedGeometryEffect(id: book.title, in: animation2, isSource: true)
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .overlay(
            ZStack{
                if libraryVM.showBookView{
                    BookPageView(animation: animation2)
                        .environmentObject(libraryVM)
                }
            }
        )
    }
}

struct CategoryBookListView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        CategoryBookListView(iconName: "Romance")
            .environmentObject(LibraryViewModel())
    }
}
