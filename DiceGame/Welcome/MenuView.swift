//
//  MenuView.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI
import NavigationStack

struct MenuView: View {
    @State private var isGoToUsersListView: Bool = false
    @State private var isGoToCreateUserView: Bool = false
    @State private var isGoToDeleteUserView: Bool = false
    var body: some View {
        NavigationStackView {
            ZStack {
                PushView(destination: usersList(), isActive: $isGoToUsersListView, label: {Text("")})
                PushView(destination: CreateNewUser(), isActive: $isGoToCreateUserView, label: {Text("")})
                PushView(destination: DeleteUserView(), isActive: $isGoToDeleteUserView, label: {Text("")})
                LinearGradient(gradient: Gradient(colors: [Color("ColorWhitePurple"), Color("ColorBananaRMIT")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(minHeight: 200, idealHeight: 220, maxHeight: 250, alignment: .center)
                        .modifier(ShadowModifier())
                        .padding()
                        .onAppear(perform: {
                            playSound(sound: "blink", type: "mp3")
                        })
                    Spacer()
                    Button(action: {
                        self.isGoToCreateUserView = true
                    }, label: {
                        Image("playnowButton")
                            .resizable()
                            .modifier(ReelImageModifier())
                    })
                    .padding(.bottom, 5)
                    Button(action: {
                        self.isGoToUsersListView = true
                    }, label: {
                        Image("continueButton")
                            .resizable()
                            .modifier(ReelImageModifier())
                    })
                    .padding(.bottom, 5)
                    Button(action: {
                        self.isGoToDeleteUserView = true
                    }, label: {
                        Image("deleteButtonOfMenu")
                            .resizable()
                            .modifier(ReelImageModifier())
                    })
                    Spacer()
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
