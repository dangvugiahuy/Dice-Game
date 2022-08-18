//
//  ContentView.swift
//  DiceGame
//
//  Created by Gia Huy on 13/08/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("saved_users") var savedUsers : [User] = []
    var body: some View {
        WelcomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
