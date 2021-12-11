//
//  LibraryView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 06/10/2021.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var bookListVM: BookListViewModel
    var body: some View {
        ZStack {
            Header(title: "Library")
            BookListView(bookListVM: bookListVM)
                
        }
        .navigationTitle("")
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(bookListVM: BookListViewModel())
    }
}
