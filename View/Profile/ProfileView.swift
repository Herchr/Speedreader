//
//  Profile.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    init() {
       // UITableView.appearance().backgroundColor = UIColor(Color.theme.background)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    var body: some View {
            VStack{
                List{
                    ForEach(profileList){ entry in
                        ProfileListEntryView(entry: entry)
                            .listRowSeparator(.hidden)
                    }
                } //:LIST
                .shadow(color: Color.gray, radius: 5, y: 3)
                Spacer()
                HStack{
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                          try firebaseAuth.signOut()
                        } catch let signOutError as NSError {
                          print("Error signing out: %@", signOutError)
                        }
                      
                    }, label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.gray)
                            .font(Font.title.bold())
                            
                            Text("Sign out")
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                        }
                    })
                    Spacer()
                }
                .padding()
                
            }//:ZSTACK
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
var profileList: [ProfileListEntry] = [
    ProfileListEntry(symbol: "book.circle", title: "My books", destination: AnyView(MyBooksView())),
    ProfileListEntry(symbol: "hare", title: "Reading speed test", destination: AnyView(WPMText(initialTest: false))),
    ProfileListEntry(symbol: "chart.xyaxis.line", title: "Statistics"),
    ProfileListEntry(symbol: "eyedropper", title: "Theme"),
    ProfileListEntry(symbol: "questionmark.circle", title: "Help and support")
    
]


// MARK: - PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

