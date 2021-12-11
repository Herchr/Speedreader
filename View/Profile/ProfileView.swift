//
//  Profile.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI

struct ProfileView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.theme.primary)
    }
    var body: some View {
        //NavigationView {
            ZStack{
                
                
                List{
                    if #available(iOS 15.0, *) {
                        ForEach(profileList){ entry in
                            ProfileListEntryView(entry: entry)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                } //:LIST
                
                Header(title:"Profile")
                
            } //:VSTACK
        //    .navigationTitle("Profile")
       // }
    }
}

// MARK: - ListEntryStruct

struct ProfileListEntry: Identifiable {
    var id: UUID = UUID()
    var symbol: String
    var title: String
    var destination: AnyView = AnyView(Color.white)
}

// MARK: - ProfileList
@available(iOS 15.0, *)
var profileList: [ProfileListEntry] = [
    ProfileListEntry(symbol: "book.circle", title: "My Books", destination: AnyView(MyBooksView())),
    ProfileListEntry(symbol: "chart.xyaxis.line", title: "Statistics"),
    ProfileListEntry(symbol: "eyedropper", title: "Theme"),
    ProfileListEntry(symbol: "questionmark.circle", title: "Help and Support")
]


// MARK: - PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

