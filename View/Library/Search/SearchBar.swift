//
//  SearchBar.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/01/2022.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .font(Font.title2.bold())
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(
            Color.theme.background
        )
        .mask(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
        )
        .padding(.horizontal)
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
