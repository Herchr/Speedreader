//
//  Profile.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State var showWPMTest: Bool = false
    init() {
       // UITableView.appearance().backgroundColor = UIColor(Color.theme.background)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    var body: some View {
            VStack{
                List{
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "book.circle", title: "My books", destination: AnyView(MyBooksView())))
                    NavigationLink(destination:
                                    WPMText(initialTest: false, isActive: $showWPMTest)
                                        .navigationBarBackButtonHidden(true)
                                        .navigationTitle("")
                                        .navigationBarHidden(true),
                                   isActive: $showWPMTest){
                        HStack{
                            ZStack {
                                Image(systemName: "hare")
                            }
                            .frame(width: 30)
                            Text("Reading speed test")
                                .font(.title3)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                //.opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        } //:HSTACK
                        .padding(.vertical)
                        
                    }
//                    .onTapGesture {
//                        showWPMTest = true
//                    }
                    
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "chart.xyaxis.line", title: "Statistics"))
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "eyedropper", title: "Theme"))
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "questionmark.circle", title: "Help and support"))
                    
                } //:LIST
                .shadow(color: Color.gray, radius: 5, y: 3)
                Spacer()
                HStack{
                    SignOutButton()
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
   // ProfileListEntry(symbol: "hare", title: "Reading speed test", destination: AnyView(WPMText(initialTest: false))),
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


struct SignOutButton: View {
    @EnvironmentObject var appViewModel: AppViewModel
    var body: some View {
        Button(action: {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            appViewModel.activeFullScreenCover = ActiveFullScreenCover.Auth
            
        }, label: {
            Color.white
                .cornerRadius(12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(.white.opacity(0.7), lineWidth: 1)
                        .blendMode(.overlay)
                        LinearGradient(colors: [Color.black, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 17, weight: .medium))
                            )
                        
                    }
                )
                .frame(width: 36, height: 36, alignment: .center)
                
        })
    }
}
