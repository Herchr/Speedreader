//
//  ContentView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/08/2021.
//

import SwiftUI
import CoreData



struct ContentView: View {
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var appViewModel: AppViewModel = AppViewModel()
    @StateObject var rsvpVM: RSVPViewModel = RSVPViewModel()
    @StateObject var kineticVM: KineticViewModel = KineticViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if appViewModel.activeFullScreenCover != nil{
                    Color.theme.background
                        .ignoresSafeArea()
                }else{
                    if appViewModel.showTabBar{
                        CustomTabBarView(vr: viewRouter)
                            .transition(.move(edge: .bottom))
                            .zIndex(1)
                    }
                    switch viewRouter.selectedTab {
                    case viewRouter.tabImages[0]:
                        RSVPView(rsvpVM: rsvpVM)
                           // .zIndex(2)
                    case viewRouter.tabImages[1]:
                        GuidedView(rsvpVM: rsvpVM, kineticVM: kineticVM)
                            //.zIndex(2)
                    case viewRouter.tabImages[2]:
                            LibraryView()
                                .zIndex(2)
                    default:
                        ProfileView()
                           // .zIndex(2)
                            .tabBarPadding()
                    }
                }
            } //:ZSTACK
            .background(Color.theme.background)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .fullScreenCover(item: $appViewModel.activeFullScreenCover) { item in
                switch item{
                case .WPMText:
                    WPMText(isActive: Binding.constant(true))
                case .Questionnaire:
                    Questionnaire(isActive: Binding.constant(true))
                case .Auth:
                    Authentication()
                }
                
            }
            .environmentObject(appViewModel)
        } //:NAVIGATIONVIEW
        .navigationViewStyle(.stack)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let screen = UIScreen.main.bounds
