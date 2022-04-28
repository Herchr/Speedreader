//
//  Countdown.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/03/2022.
//

import SwiftUI

struct Countdown: View {
    @State var second = 3
    @Binding var countdown: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            Text("\(second)")
                .font(.system(size: 80))
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.text)
                .onReceive(timer) { _ in
                    if second - 1 == 0{
                        countdown = false
                        self.timer.upstream.connect().cancel()
                        return
                    }
                    second -= 1
                }
        }
 
    }
}

struct Countdown_Previews: PreviewProvider {
    static var previews: some View {
        Countdown(countdown: Binding.constant(true))
    }
}
