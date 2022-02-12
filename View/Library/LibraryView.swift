//
//  LibraryView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 06/10/2021.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var libraryVM: LibraryViewModel = LibraryViewModel()
    @Namespace var animation
    @Namespace var searchbar
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    if libraryVM.searchActivated{
                        SearchBar() // For å hindre resten av content i å bli flyttet ned
                    }
                    else{
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: searchbar)
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.1)
                .padding(.horizontal,10)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        libraryVM.searchActivated.toggle()
                    }
                }
                VStack(alignment: .leading){
                    Text("Featured")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 40)
                        .padding(.leading, 30)
                    BookListView(animation: animation)
                        .environmentObject(libraryVM)
                }
                CategoriesView()
                    .padding(.vertical, 20)
                    .environmentObject(libraryVM)
                    .tabBarPadding()

                Spacer()
            } //:VSTACK
            .navigationTitle("")
            .padding(.top)
            .background(
                BlobView()
            )
            
            
        } //: ZSTACK
        .overlay(
            ZStack{
                if libraryVM.searchActivated{
                    SearchView(animation: searchbar)
                        .environmentObject(libraryVM)
                }
            }
        )
        .overlay(
            ZStack{
                if libraryVM.showBookView{
                    BookView(animation: animation)
                        .environmentObject(libraryVM)
                }
            }
        )
        

    }
}

struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView(libraryVM: LibraryViewModel())
//    }
    static var previews: some View {
        ContentView()
    }
}
