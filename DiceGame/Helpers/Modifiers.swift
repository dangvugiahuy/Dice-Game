//
//  Modifiers.swift
//  DiceGame
//
//  Created by Gia Huy on 13/08/2022.
//

import SwiftUI

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}

struct IconImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 35, idealWidth: 50, maxWidth: 55, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .heavy, design: .rounded))
    }
}

struct betNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 25, weight: .heavy, design: .rounded))
    }
}

struct scoreLabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
}

struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
      .accentColor(Color.white)
      .padding()
  }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorBlackTransparent")))
    }
}

struct ReelImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct ChartButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 70, idealWidth: 90, maxWidth: 100, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct BetCapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 17, weight: .heavy, design: .rounded))
            .modifier(ShadowModifier())
            .background(
                Capsule().fill(LinearGradient(gradient: Gradient(colors: [Color("ColorYellowRMIT"), Color("ColorRedRMIT")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 90, height: 50, alignment: .center)
            )
    }
}

struct CasinoChipModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 70)
            .modifier(ShadowModifier())
    }
}

