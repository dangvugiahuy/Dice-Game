//
//  userRow.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI

struct userRow: View {
    let user: User
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorBananaRMIT"), Color("ColorBrightPurpleRMIT")]), startPoint: .top, endPoint: .bottom)
            HStack {
                VStack {
                    Image(user.imageName)
                        .resizable()
                        .modifier(IconImageModifier())
                        .offset(y: 5)
                    Text(user.name)
                        .modifier(scoreNumberStyle())
                        .offset(y: -5)
                }
                .padding(.leading, 10)
                Spacer()
                Text("High Scores: \(user.highscore)")
                    .offset(x: -30)
                    .padding(.leading)
                    .modifier(scoreNumberStyle())
            }
        }
        .cornerRadius(15)
        .padding()
    }
}

//struct userRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            userRow(user: users[0])
//                .previewLayout(.fixed(width: 350, height: 120))
//            userRow(user: users[1])
//                .previewLayout(.fixed(width: 350, height: 120))
//        }
//        usersList()
//    }
//}
