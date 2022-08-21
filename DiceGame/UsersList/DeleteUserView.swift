//
//  DeleteUserView.swift
//  DiceGame
//
//  Created by Gia Huy on 17/08/2022.
//

import SwiftUI
import NavigationStack

struct DeleteUserView: View {
    @AppStorage("saved_users") var savedUsers : [User] = []
    @State private var isGoBackToRoot: Bool = false
    @State private var isGoToUsersListView: Bool = false
    @State private var isDeleteSucces: Bool = false
    @State private var isDeleteFail: Bool = false
    @State private var id: String = ""
    
    func validateID(id: String) -> Bool {
        if Int(id) != nil && Int(id)! <= savedUsers.count {
            return true
        }
        return false
    }
    
    func indexOfUser() -> Int {
        let indexUser = savedUsers.firstIndex(where: {$0.id == Int(id)})
        return indexUser!
    }
    
    var body: some View {
        ZStack {
            PopView(isActive: $isGoBackToRoot, label: {Text("")})
            PushView(destination: usersList(), isActive: $isGoToUsersListView, label: {Text("")})
            LinearGradient(gradient: Gradient(colors: [Color("ColorBrightPurpleRMIT"), Color("ColorBananaRMIT")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(minHeight: 190, idealHeight: 190, maxHeight: 230, alignment: .center)
                    .modifier(ShadowModifier())
                    .padding()
                Text("❗️DELETE USER❗️")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .heavy, design: .rounded))
                    .padding(.bottom, 180)
                TextField("Type your user id...", text: $id)
                    .padding()
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .background()
                    .cornerRadius(30)
                    .frame(width: 350, height: 30)
                    .padding(.bottom, 25)
                    .keyboardType(.default)
                Button(action: {
                    if validateID(id: id) == true {
                        savedUsers.remove(at: indexOfUser())
                        isDeleteSucces = true
                    } else {
                        isDeleteFail = true
                    }
                    
                }, label: {
                    Image("deleteButton")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 150, idealWidth: 170, maxWidth: 185, alignment: .center)
                        .modifier(ShadowModifier())
                })
                Spacer()
            }
            .overlay(
                Button(action: {
                    self.isGoBackToRoot = true
                }, label: {
                    Image(systemName: "chevron.left.circle")
                        .foregroundColor(.white)
                })
                .modifier(ButtonModifier()), alignment: .topLeading
            )
            if isDeleteFail {
                ZStack {
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("DELETE FAILED⚠️")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(Color("ColorRedRMIT"))
                        
                        Spacer()
                        
                        VStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("You have not entered the ID or maybe the player ID is not found")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.isDeleteFail = false
                                self.id = ""
                            } label: {
                                Text("Try Again".uppercased())
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundColor(Color("ColorRedRMIT"))
                            )
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(Color("ColorBlueRMIT"))
                    .cornerRadius(20)
                }
            }
            
            if isDeleteSucces {
                ZStack {
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("DELETE SUCCESS😢")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.green)
                            .padding()
                            .frame(minWidth: 220, idealWidth: 250, maxWidth: 330)
                            .background(Color("ColorRedRMIT"))
                        
                        Spacer()
                        
                        VStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("Thank you for playing my game\nYou will be taken to the player list screen")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.isGoToUsersListView = true
                            }, label: {
                                Text("OK!".uppercased())
                                    .padding(.vertical,10)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 2)
                                            .foregroundColor(Color("ColorRedRMIT"))
                                    )
                            })
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(Color("ColorBlueRMIT"))
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct DeleteUserView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteUserView()
            .previewInterfaceOrientation(.portrait)
    }
}
