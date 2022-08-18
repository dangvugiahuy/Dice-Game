//
//  LogoView.swift
//  DiceGame
//
//  Created by Gia Huy on 13/08/2022.
//

import SwiftUI

struct LogoView: View {
    var logoFileName: String
    
    var body: some View {
        Image(logoFileName)
            .resizable()
            .scaledToFit()
            .frame(minHeight: 170, idealHeight: 170, maxHeight: 170, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(logoFileName: "logo")
    }
}
