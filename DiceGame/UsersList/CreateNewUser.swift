//
//  CreateNewUser.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI
import NavigationStack
struct CreateNewUser: View {
    @AppStorage("saved_users") var savedUsers : [User] = []
    @State private var name: String = ""
    @State private var imageName: String = "boy_1"
    @State private var isCreateLost: Bool = false
    @State private var isCreateSucces: Bool = false
    @State private var isGoBackToRoot: Bool = false
    @State private var isGoToUsersListView: Bool = false
    private let ImageOption: [String] = [
        "boy_1", "boy_2", "boy_3",
        "girl_1", "girl_2", "girl_3",
        "cat_1", "cat_2",
        "dog_1", "dog_2"
    ]
    
    func validateName() -> Bool {
        if name.count > 0 && name.count <= 15 {
            return true
        }
        return false
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
                Text("CREATE NEW USER")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .heavy, design: .rounded))
                    .padding(.bottom, 20)
                VStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 100, idealWidth: 120, maxWidth: 150, alignment: .center)
                        .modifier(ShadowModifier())
                        .padding()
                    Menu {
                        Picker(selection: $imageName) {
                            ForEach(ImageOption, id: \.self) { image in
                                    HStack {
                                        Text("Choose Avatar")
                                        Image(image)
                                    }
                                }
                        } label: {}
                    } label: {
                        Text("Choose Avatar")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding(.bottom, 40)
                    }
                }
                TextField("Type your name...", text: $name)
                    .padding()
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .background()
                    .cornerRadius(30)
                    .frame(width: 350, height: 30)
                    .padding(.bottom, 25)
                    .keyboardType(.default)
                Button(action: {
                    if validateName() == true {
                        savedUsers.append(User(id: savedUsers.count+1, name: name, money: 1000, highscore: 0, imageName: imageName))
                        isCreateSucces = true
                    } else {
                        isCreateLost = true
                    }
                    
                }, label: {
                    Text("SAVE")
                        .padding()
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .frame(width: 200, height: 50)
                        .background(Color.blue.cornerRadius(20))
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
            if isCreateLost {
                ZStack {
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("CREATE FAILED⚠️")
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
                            Text("The maximum length of the name is only 15 characters")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.isCreateLost = false
                                self.name = ""
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
            
            if isCreateSucces {
                ZStack {
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("CREATE SUCCESS🥳")
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
                            Text("You will be taken to the player list screen")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.isGoToUsersListView = true
                            }, label: {
                                Text("Les't GO!".uppercased())
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

struct CreateNewUser_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewUser()
    }
}
