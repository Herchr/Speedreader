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
                .frame(width: screen.width / 1.1)
                .padding(.horizontal,10)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut){
                        libraryVM.searchActivated.toggle()
                    }
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("Featured")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, screen.height * 0.03)
                        .padding(.leading, 30)
                    FeaturedBookListView(animation: animation)
                        .environmentObject(libraryVM)
                }
                VStack {
                    CategoriesView()
                        .environmentObject(libraryVM)
                        .padding(.top, screen.height*0.05)
                        .ignoresSafeArea(.keyboard, edges: .all)
                        //.tabBarPadding()
                }
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        )
        .overlay(
            ZStack{
                if libraryVM.showBookView{
                    BookPageView(animation: animation)
                        .environmentObject(libraryVM)
                }
            }
        )
        .fullScreenCover(isPresented: $libraryVM.showCategoryBookListView){
            ZStack{
                CategoryBookListView(iconName: libraryVM.selectedCategory.title)
                    .environmentObject(libraryVM)
            }
        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView(libraryVM: LibraryViewModel())
//    }
    static var previews: some View {
        LibraryView()
    }
}
