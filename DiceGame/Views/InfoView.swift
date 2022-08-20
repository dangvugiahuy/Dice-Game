//
//  InfoView.swift
//  DiceGame
//
//  Created by Gia Huy on 13/08/2022.
//

import SwiftUI

struct InfoView: View {
  @Environment(\.presentationMode) var presentationMode
    @State public var userInfo: User
  var body: some View {
      ZStack{
          Color("ColorWhitePurple")
          VStack(alignment: .center, spacing: 20) {
            LogoView(logoFileName: "logo")
            Spacer()
            
            Form {
                Section(header: Text("User info")) {
                    Image("\(userInfo.imageName)")
                        .resizable()
                        .modifier(IconImageModifier())
                    Text("ID: \(userInfo.id)")
                    Text("Name: \(userInfo.name)")
                    Text("Money: \(userInfo.money)")
                    Text("High Score: \(userInfo.highscore)")
                }
                Section(header: Text("How To Play")) {
                    Text("Just push the spin button to play.")
                    Text("HIGH  -> for choose SUM numbers (11 - 18)\nLOW   -> for choose SUM numbers (3 - 10)")
                    Text("- The amount of the bonus will be added to the account equal to the amount of coins you bet.")
                    Text("- If the dice roll to 3 identical faces and SUM is HIGH -> The winning amount will be 10x of your betting amount if you choose HIGH (this is also similar to LOW).")
                    Text("- If you lose, you will be deducted x5 of the bet amount")
                    Text("You can reset the money and highscore by clicking on the button Reset.")
                }
                Section(header: Text("Application Information")) {
                    HStack {
                      Text("App Name")
                      Spacer()
                      Text("RMIT Dice Game")
                    }
                    HStack {
                      Text("Course")
                      Spacer()
                      Text("COSC2659")
                    }
                    HStack {
                      Text("Year Published")
                      Spacer()
                      Text("2022")
                    }
                    HStack {
                      Text("Location")
                      Spacer()
                      Text("Saigon South Campus")
                    }
                }
            }
            .font(.system(.body, design: .rounded))
          }
          .padding(.top, 40)
          .overlay(
            Button(action: {
              audioPlayer?.stop()
              self.presentationMode.wrappedValue.dismiss()
            }) {
              Image(systemName: "xmark.circle")
                .font(.title)
            }
            .foregroundColor(.white)
            .padding(.top, 30)
            .padding(.trailing, 20),
            alignment: .topTrailing
            )
            .onAppear(perform: {
              playSound(sound: "drum-music", type: "mp3")
            })
      }
    
  }
}
