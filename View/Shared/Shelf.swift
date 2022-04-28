//
//  Shelf.swift
//  Speedreader
//
//  Created by Herman Christiansen on 21/04/2022.
//

import SwiftUI

struct Shelf: View {
    var body: some View {
        Image("BookShelf")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct Shelf_Previews: PreviewProvider {
    static var previews: some View {
        Shelf()
    }
}
