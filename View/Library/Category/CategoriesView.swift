//
//  CategoryView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 15/12/2021.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.text)
                .padding(.leading, 30)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    GenreIcon(iconName: "Romance")
//                    ForEach(categories, id: \.self.id){ category in
//                        ZStack{
//                            PillView(category: category)
//                                .onTapGesture {
//                                    withAnimation{
//                                        libraryVM.selectedCategory = category
//                                    }
//                                }
//                        }
//                    }
                }
                .padding([.horizontal, .bottom], 30)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(LibraryViewModel())
    }
}
