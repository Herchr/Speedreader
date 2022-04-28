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
    @ObservedObject var rsvpVM: RSVPViewModel
    
//    init(rsvpVM: RSVPViewModel) {
//       // UITableView.appearance().backgroundColor = UIColor(Color.theme.background)
//        UITableView.appearance().backgroundColor = UIColor.clear
//        self.rsvpVM = rsvpVM
//    }
    var body: some View {
        VStack(spacing: 0){
                HStack {
                    Text("Profile")
                        .font(Font.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .padding(.leading)
                VStack(alignment: .leading, spacing: 0){
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "book.circle.fill", title: "My books", destination: AnyView(MyBooksView().navigationBarTitle("").navigationBarTitleDisplayMode(.inline))))
                    Divider()
                        .padding(.horizontal)
                    NavigationLink(destination: WPMText(initialTest: false, isActive: $showWPMTest)
                                                    ,
                                   isActive: $showWPMTest){
                        HStack{
                            ZStack {
                                Image(systemName: "hare.fill")
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
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "gearshape.fill", title: "Settings", destination: AnyView(Settings(rsvpVM: rsvpVM))))
                    Divider()
                        .padding(.horizontal)
                    ProfileListEntryView(entry: ProfileListEntry(symbol: "questionmark.circle.fill", title: "Help and support"))
                    
                } //:LIST
                .frame(width: screen.width * 0.8)
                .padding(20)
//                .background(.ultraThinMaterial)
                .background(ZStack {
                    BlurView(style: .systemUltraThinMaterialDark)
                })
                .mask(RoundedRectangle(cornerRadius: 40, style: .continuous))
                .foregroundColor(.white)
                .shadow(radius: 6, x: 3, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                        .blendMode(.overlay)
                )
                
                .padding(.top, 20)
                
                Spacer()
                HStack(){
                    SignOutButton()
                    Spacer()
                }
                .padding([.top, .horizontal])
                .tabBarPadding()
                
            }//:VSTACK
            .background(
                ZStack{
                    Image("GuidedBGCircles")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: screen.height)
                        .ignoresSafeArea()
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
    ProfileListEntry(symbol: "gearshape", title: "Settings"),
    ProfileListEntry(symbol: "questionmark.circle", title: "Help and support")
    
]


// MARK: - PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(rsvpVM: RSVPViewModel())
    }
}


struct SignOutButton: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State var showLogoutModal: Bool = false
    func signout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        appViewModel.activeFullScreenCover = ActiveFullScreenCover.Auth
    }
    
    var body: some View {
        Button(action: {
            showLogoutModal=true
        }, label: {
            Color.clear
//                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .background(ZStack {
                    BlurView(style: .systemUltraThinMaterialDark)
                })
                .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                )
                .shadow(radius: 6, x: 3, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                        .blendMode(.overlay)
                )
                .frame(width: 44, height: 44, alignment: .center)
                
        })
            .alert(isPresented: $showLogoutModal) {
                Alert(title: Text("Are you sure you want to log out?"), primaryButton: .destructive(Text("Log out"), action: {
                    signout()
                }), secondaryButton: .cancel(Text("Cancel"), action: {
                    showLogoutModal=false
                }))
            }
    }
}
