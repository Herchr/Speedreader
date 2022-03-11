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
                VStack(alignment: .leading, spacing: 0){
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "book.circle", title: "My books", destination: AnyView(MyBooksView())))
                    Divider()
                        .padding(.horizontal)
                    NavigationLink(destination: WPMText(initialTest: false, isActive: $showWPMTest)
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
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(Font.caption.bold())
                        } //:HSTACK
                        .padding([.vertical, .leading, .trailing])
                        
                    }
                    Divider()
                        .padding(.horizontal)
//                    .onTapGesture {
//                        showWPMTest = true
//                    }
                    
//                    ProfileListEntryView(entry: ProfileListEntry(symbol: "chart.xyaxis.line", title: "Statistics"))
//                    Divider()
//                        .padding(.horizontal)
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "eyedropper", title: "Theme"))
                    Divider()
                        .padding(.horizontal)
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "questionmark.circle", title: "Help and support"))
                    
                } //:LIST
                .shadow(color: Color.gray, radius: 5, y: 3)
                .frame(width: screen.width * 0.9)
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .mask(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                        .blendMode(.overlay)
                )
                .padding(.top, 20)
                
                Spacer()
                HStack{
                    SignOutButton()
                    Spacer()
                }
                .padding()
                
            }//:VSTACK
            .background(
                ZStack{
                    Image("GuidedBG4")
//                        .resizable()
//                        .scaledToFill()
//                        .scaleEffect(1.2)
                }
            )
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
            Color.clear
                .cornerRadius(16)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    ZStack {
//                        RoundedRectangle(cornerRadius: 12, style: .continuous)
//                            .stroke(.white.opacity(0.3), lineWidth: 1)
//                        .blendMode(.overlay)
                        LinearGradient(colors: [Color.white, Color.white.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 20, weight: .medium))
                            )
                        
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                        .blendMode(.overlay)
                )
                .frame(width: 44, height: 44, alignment: .center)
                
        })
    }
}
