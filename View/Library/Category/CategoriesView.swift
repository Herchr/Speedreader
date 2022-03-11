//
//  CategoryView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 15/12/2021.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    
    var rows = [GridItem(.flexible(maximum: 60))]
    
    @State private var contentSize: CGSize = CGSize(width: 400, height: 0)
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Categories")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.text)
                .padding(.leading, 30)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows, spacing: 20){
                    ForEach(categories, id: \.self.id){ category in
                        ZStack{
                            GenreIcon(iconName: category.title)
                                .onTapGesture {
                                    withAnimation{
                                        libraryVM.selectedCategory = category
                                        libraryVM.showCategoryBookListView = true
                                    }
                                }
                        }
                    }
                }
                .padding(.leading, 30)
            }
            .background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        contentSize = geo.size
                    }
                    return Color.clear
                }
            )
            .frame(maxHeight: contentSize.width - 280)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(LibraryViewModel())
    }
}
