//
//  usersList.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI
import NavigationStack

struct usersList: View {
    @State private var isGoBackToRoot: Bool = false
    @AppStorage("saved_users") var savedUsers : [User] = []
    
    func UserSortedByScore() -> [User]{
        return savedUsers.sorted(by: { $0.highscore > $1.highscore })
    }
    
    func Top3UserHighScore() -> [User]{
        let userArrayAfterSort = UserSortedByScore()
        var top3UserArray: [User] = []
        if userArrayAfterSort.count == 1 {
            let firstUser = userArrayAfterSort[0]
            top3UserArray.append(firstUser)
        } else if userArrayAfterSort.count == 2 {
            let firstUser = userArrayAfterSort[0]
            let secondUser = userArrayAfterSort[1]
            top3UserArray.append(contentsOf: [firstUser, secondUser])
        } else if userArrayAfterSort.count == 3 {
            let firstUser = userArrayAfterSort[0]
            let secondUser = userArrayAfterSort[1]
            let thirdUser = userArrayAfterSort[2]
            top3UserArray.append(contentsOf: [firstUser, secondUser, thirdUser])
        }
        return top3UserArray
    }
    
    func user4thToN() -> [User] {
        let userArrayAfterSort = UserSortedByScore()
        var userArray: [User] = []
        
        for i in 3...userArrayAfterSort.count-1 {
            userArray.append(userArrayAfterSort[i])
        }
        
        return userArray
    }
    
    func displayallUser() -> [User] {
        let userArrayAfterSort = UserSortedByScore()
        var userArray: [User] = []
        
        for i in 0...2 {
            userArray.append(userArrayAfterSort[i])
        }
        
        return userArray
    }
    
    var body: some View {
        ZStack {
            PopView(isActive: $isGoBackToRoot, label: {Text("")})
            LinearGradient(gradient: Gradient(colors: [Color("ColorWhitePurple"), Color("ColorPurpleDark")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("CHOOSE YOUR PROFILE")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                    .padding(.top, 45)
                    
                if UserSortedByScore().count == 0 {
                    Spacer()
                    Text("player list is currently empty!")
                        .foregroundColor(.black)
                        .font(.system(size: 25, weight: .heavy, design: .rounded))
                        .padding(.bottom, 20)
                    Spacer()
                } else if UserSortedByScore().count != 0 {
                    if UserSortedByScore().count > 0 && UserSortedByScore().count <= 3 {
                        Spacer()
                        VStack {
                            Text("Top 3 players🏆")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .padding(.bottom, 20)
                            
                            ForEach(Top3UserHighScore(), id: \.self) { user in
                                PushView(destination: GameView(user: user), label: {
                                    userRow(user: user)
                                })
                            }
                        }
                        VStack {
                           Text("There are no players in the top 4")
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .heavy, design: .rounded))
                                .padding(.bottom, 20)
                        }
                        Spacer()
                    } else if UserSortedByScore().count > 3 {
                        Spacer()
                        VStack {
                            Text("🏆Top 3 players🏆")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .padding(.bottom, 20)
                            ForEach(displayallUser(), id: \.self) { user in
                                PushView(destination: GameView(user: user), label: {
                                    userRow(user: user)
                                })
                            }
                        }
                        VStack {
                            Text("4th - \(UserSortedByScore().count)")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .padding(.bottom, 20)
                            ScrollView {
                                ForEach(user4thToN(), id: \.self) { user in
                                    PushView(destination: GameView(user: user), label: {
                                        userRow(user: user)
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                }
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
        }
    }
}

struct usersList_Previews: PreviewProvider {
    static var previews: some View {
        usersList()
    }
}
