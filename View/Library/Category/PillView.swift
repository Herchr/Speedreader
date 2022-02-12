//
//  PillView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 15/12/2021.
//

import SwiftUI

struct PillView: View {
    let category: Category
    @EnvironmentObject var libraryVM: LibraryViewModel
    var body: some View {
        HStack(spacing: 12){
            if category.image.count > 0{
                Image(category.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .padding(6)
                    .background(libraryVM.selectedCategory.id == category.id ? Color.white : Color.clear)
                    .clipShape(Circle())
                    
                Text("\(category.title)")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(libraryVM.selectedCategory.id == category.id ? Color.white : Color.theme.text)
                    
            }else{
                Text("\(category.title)")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(libraryVM.selectedCategory.id == category.id ? Color.white : Color.theme.text)
                    .padding(4)
            }
            
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(libraryVM.selectedCategory.id == category.id ? Color.theme.accent : Color.gray.opacity(0.1))
        .clipShape(Capsule())
        
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(category: Category(title: "Sci-Fi"))
            .environmentObject(LibraryViewModel())
    }
}
