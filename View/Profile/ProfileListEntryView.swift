//
//  ProfileListEntryView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI

struct ProfileListEntryView: View {
    var entry: ProfileListEntry
    
    var body: some View {
        NavigationLink(destination: entry.destination){
            HStack{
                ZStack {
                    Image(systemName: entry.symbol)
                }
                .frame(width: 30)
                Text("\(entry.title)")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    //.opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            } //:HSTACK
            .padding(.vertical)
        }
    }
}

struct ProfileListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
