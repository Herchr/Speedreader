//
//  BookViewBackButton.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/10/2021.
//

import SwiftUI

struct BookViewBackButton: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    libraryVM.showBookView = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 12, height: 20)
                    .foregroundColor(.white)
            })
                .padding(15)
            Spacer()
        }
    }
}

struct BookViewBackButton_Previews: PreviewProvider {
    static var previews: some View {
        BookViewBackButton()
    }
}
