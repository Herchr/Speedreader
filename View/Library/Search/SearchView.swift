//
//  SearchBarView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 12/01/2022.
//

import SwiftUI

struct SearchView: View {
    var books: [Book] = bookExamples
    @EnvironmentObject var libraryVM: LibraryViewModel
    //@FocusState var startTF: Bool
    var animation: Namespace.ID
    @Namespace var bookAnimation
    @FocusState private var searchIsFocused: Bool
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 15){
                
                // Back button
                Button(action: {
                    print("back button search view")
                    withAnimation{
                        libraryVM.searchActivated.toggle()
                    }
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                })
                    .frame(width: 44, height: 44)
                
                //Search bar
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(Font.title2.bold())
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $libraryVM.searchText)
                        .focused($searchIsFocused)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 5)
                            .shadow(color: .blue, radius: 1, x: 0, y: 0)
                )
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 40)
                
            }
            .padding([.horizontal, .top])
            
            
            if let books = libraryVM.searchedBooks{
                if books.isEmpty{
                    VStack(spacing: 10){
                        Text("No books found")
                            .font(.title)
                    }
                    .padding()
                }else{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 0){
                            
                            // Found Text...
                            Text("Found \(books.count) results")
                                .font(.title.bold())
                                .padding(.vertical)
                            
                                StaggeredGrid(columns: 2,spacing: 20, list: books) {book in
                                    BookView(bookTitle: book.title, bookImg: book.img)
                                        .matchedGeometryEffect(id: book.title, in: bookAnimation)
                                        .onTapGesture{
                                            searchIsFocused = false
                                            withAnimation{
                                                libraryVM.selectedBook = book
                                                libraryVM.showBookView.toggle()
                                            }
                                        }
                                }
                            
                        }
                        .padding()
                    }
                }
            }
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(
            Color.white
                //.opacity(0.1)
               // .ignoresSafeArea()
        )
        .overlay(
            ZStack{
                if libraryVM.showBookView{
                    BookPageView(animation: bookAnimation)
                        .environmentObject(libraryVM)
                }
            }
        )
        .onAppear{
            searchIsFocused = true
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @Namespace static var ns
    static var previews: some View {
        ZStack {
            SearchView(animation: ns)
                .environmentObject(LibraryViewModel())
        }
    }
}
