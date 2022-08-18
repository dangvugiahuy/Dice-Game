//
//  GreetingView.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI

struct GreetingView: View {
    @Binding var active: Bool
    var body: some View {
        
        ZStack {
            // MARK: - BACKGROUND
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                  playSound(sound: "Melodia-dla-Zuzi-Wacek", type: "mp3")
                })
            
            VStack {
                Spacer(minLength: 450)
                Button(action: {
                    active = false
                }, label: {
                    Image("playButton")
                        .resizable()
                        .modifier(ReelImageModifier())
                })
                Spacer(minLength: 0)
            }
        }
    }
}








struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(active: .constant(true))
    }
}
