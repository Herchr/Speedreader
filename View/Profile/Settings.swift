//
//  Settings.swift
//  Speedreader
//
//  Created by Herman Christiansen on 12/03/2022.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    @State var darkMode: Bool = false
    var body: some View {
        VStack {
            List{
                Toggle(isOn: $rsvpVM.punctuationPause){
                    Text("Punctuation pause")
                }
                Toggle(isOn: $darkMode){
                    Text("Dark mode(not working)")
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(rsvpVM: RSVPViewModel())
    }
}
