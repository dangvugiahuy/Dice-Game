//
//  GameView.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import SwiftUI
import NavigationStack

struct GameView: View {
    @State private var userInfo: User
    init(user: User) {
        userInfo = User(id: user.id, name: user.name, money: user.money, highscore: user.highscore, imageName: user.imageName)
    }
    // MARK: - PROPERTIES
    let dicesFace = ["dice_1", "dice_2", "dice_3", "dice_4", "dice_5", "dice_6"]
    @AppStorage("saved_users") var savedUsers : [User] = []
    @State private var betAmount = 10                //Số tiền đặt cược
    @State private var resultOfRoll = 0             //Biến chứa kết quả của mỗi lần roll
    @State private var animatingIcon = false
    @State private var isChooseBetbutton = false
    @State private var isGoBackToUsersListView: Bool = false
    @State private var validateBet = true
    
    let haptics = UINotificationFeedbackGenerator()
    
    @State private var dices = [0, 1, 2]
    
    @State private var isChooseMin = true       //ĐẠI DIỆN CHO XỈU
    @State private var isChooseMax = false      //ĐẠI DIỆN CHO TÀI
    
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    
    // MARK: - GET INDEX OF USER
    func indexOfUser() -> Int {
        let indexUser = savedUsers.firstIndex(where: {$0.id == userInfo.id})
        return indexUser!
    }
    
    // MARK: - FUNCTIONS (GAME LOGICS)
    
    // MARK: - Determine if the 3 faces of each dice are the same?
    func AreThreeFacesSame() -> Bool{
        if dices[0] == dices[1] && dices[0] == dices[2] {
            return true
        }
        return false
    }
    
    // MARK: - Determine if the Sum is MIN (3 - 10 points)
    func SumIsMin() -> Bool{
        if resultOfRoll >= 3 && resultOfRoll <= 10 {
            return true
        }
        return false
    }
    
    // MARK: - Determine if the Sum is MAX (11 - 18 points)
    func SumIsMax() -> Bool{
        if resultOfRoll >= 11 && resultOfRoll <= 18 {
            return true
        }
        return false
    }
    
    // MARK: - ROLL LOGIC
    func RollDices(){
        dices = dices.map({ _ in
            Int.random(in: 0...dicesFace.count - 1)
        })
        resultOfRoll = (dices[0] + 1) + (dices[1] + 1) + (dices[2] + 1)
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // MARK: - CHECK WINNING LOGIC
    func checkWinning(){
        //BẠN CHỌN MAX -> ĐỒNG NGHĨA LÀ BẠN CHỌN TÀI (dự đoán tổng sẽ rơi vào 11 - 18 điểm)
        //BẠN CHỌN MIN -> ĐỒNG NGHĨA LÀ BẠN CHỌN XỈU (dự đoán tổng sẽ rơi vào 3 - 10 điểm)
        
        if SumIsMin() == true && isChooseMin == true {
            // PLAYER WINS LOGIC
             playerWins()
            
            // NEW HIGHSCORE LOGIC
            if savedUsers[indexOfUser()].money > savedUsers[indexOfUser()].highscore{
                newHighScore()
            }
        } else if SumIsMax() == true && isChooseMax == true {
            // PLAYER WINS LOGIC
            playerWins()
            
            // NEW HIGHSCORE LOGIC
            if savedUsers[indexOfUser()].money > savedUsers[indexOfUser()].highscore{
                newHighScore()
            }
        } else {
            // PLAYER LOSES
            playLoses()
        }
    }
    
    
    // MARK: - PLAYER WIN LOGIC
    func playerWins() {
        //Nếu đổ xúc xắc ra 3 mặt giống nhau và tổng là TÀI (11 - 18 điểm) -> nếu ván đó bạn chọn MAX (Đại diện cho TÀI) -> NỔ HŨ (số coin đặt ván đó x 10)
        //Nếu đổ xúc xắc ra 3 mặt giống nhau và tổng là XỈU (3 - 10 điểm) -> nếu ván đó bạn chọn MIN (Đại diện cho XỈU) -> NỔ HŨ (số coin đặt ván đó x 10)
        //Nếu 2 trường hợp trên không thoả thì sẽ thực hiện cộng tiền như bình thường -> (số coin đặt ván đó được cộng vào tiền)
        if isChooseMax == true && AreThreeFacesSame() == true && SumIsMax() == true{
            savedUsers[indexOfUser()].money += betAmount * 10
            playSound(sound: "highscore", type: "mp3")
        } else if isChooseMin == true && AreThreeFacesSame() == true && SumIsMin() == true{
            savedUsers[indexOfUser()].money += betAmount * 10
            playSound(sound: "highscore", type: "mp3")
        } else {
            savedUsers[indexOfUser()].money += betAmount
            playSound(sound: "winning", type: "mp3")
        }
    }
    
    // MARK: - HIGHSCORE LOGIC
    func newHighScore(){
        savedUsers[indexOfUser()].highscore = savedUsers[indexOfUser()].money
        playSound(sound: "highscore", type: "mp3")
    }
    
    // MARK: - PLAYER LOSE LOGIC
    func playLoses() {
        //Nếu đổ xúc xắc ra 3 mặt giống nhau và tổng là TÀI (11 - 18 điểm) -> nếu ván đó bạn chọn MIN (Đại diện cho XỈU) -> Bạn bị trừ số tiền cược x 5
        //Nếu đổ xúc xắc ra 3 mặt giống nhau và tổng là Xỉu (3 - 10 điểm) -> nếu ván đó bạn chọn MAX (Đại diện cho TÀI) -> Bạn bị trừ số tiền cược x 5
        //Nếu 2 trường hợp trên không thoả thì sẽ thực hiện trừ tiền như bình thường -> ( bị trừ đi số coin đặt ván đó)
        if isChooseMax == true && AreThreeFacesSame() == true && SumIsMin() == true {
            savedUsers[indexOfUser()].money -= betAmount * 5
        } else if isChooseMin == true && AreThreeFacesSame() == true && SumIsMax() == true{
            savedUsers[indexOfUser()].money -= betAmount * 5
        } else {
            savedUsers[indexOfUser()].money -= betAmount
        }
        
        if savedUsers[indexOfUser()].money < 0 {
            savedUsers[indexOfUser()].money = 0
        } else {return}
    }
    
    // MARK: - BET MAX LOGIC (CHỌN TÀI)
    func chooseMax() {
        isChooseMax = true
        isChooseMin = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - BET MIN LOGIC (CHỌN XỈU)
    func chooseMin() {
        isChooseMin = true
        isChooseMax = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - GAME OVER LOGIC
    func isGameOver() {
        if savedUsers[indexOfUser()].money <= 0 {
            // SHOW MODAL MESSAGE OF GAME OVER
            showGameOverModal = true
            playSound(sound: "gameover", type: "mp3")
        }
    }
    
    // MARK: - RESET GAME LOGIC
    func resetGame(){
        savedUsers[indexOfUser()].highscore = 0
        savedUsers[indexOfUser()].money = 1000
        chooseMin()
        playSound(sound: "ring-up", type: "mp3")
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            PopView(isActive: $isGoBackToUsersListView, label: {Text("")})
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorBananaRMIT"), Color("ColorBrightPurpleRMIT")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            // MARK: - GAME UI
            VStack {
                // MARK: - LOGO HEADER
                LogoView(logoFileName: "logo")
                    .padding(.top, 30)
                    .padding()
                    .navigationBarHidden(true)
                
                // MARK: - SCORE
                HStack{
                    
                    HStack{
                        Text("Your\nMoney".uppercased())
                            .modifier(scoreLabelStyle())
                            .multilineTextAlignment(.trailing)
                        Text("\(savedUsers[indexOfUser()].money)")
                            .modifier(scoreNumberStyle())
                            
                    }
                    .modifier(scoreCapsuleStyle()
                    )
                    
                    Spacer()
                    HStack{
                        Text("\(savedUsers[indexOfUser()].highscore)")
                            .modifier(scoreNumberStyle())
                            .multilineTextAlignment(.leading)
                        Text("High\nScore".uppercased())
                            .modifier(scoreLabelStyle())
                    }
                    .modifier(scoreCapsuleStyle()
                    )
                }
                Spacer()
                // MARK: - SLOT MACHINE
                VStack{
                    // MARK: - SECOND REEL
                    ZStack{
                        ReelView()
                        Image(dicesFace[dices[0]])
                            .resizable()
                            .modifier(IconImageModifier())
                            .rotationEffect(Angle(degrees: animatingIcon ? 1080 : 0))
                            .animation(Animation.easeInOut(duration: 1).repeatCount(1), value: animatingIcon)
                            .onAppear(perform: {
                                self.animatingIcon.toggle()
                                playSound(sound: "blink", type: "mp3")
                            })
                    }
                    HStack{
                        
                        // MARK: - SECOND REEL
                        ZStack{
                            ReelView()
                            Image(dicesFace[dices[1]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .rotationEffect(Angle(degrees: animatingIcon ? 1080 : 0))
                                .animation(Animation.easeInOut(duration: 1).repeatCount(1), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - THIRD REEL
                        ZStack{
                            ReelView()
                            Image(dicesFace[dices[2]] )
                                .resizable()
                                .modifier(IconImageModifier())
                                .rotationEffect(Angle(degrees: animatingIcon ? 1080 : 0))
                                .animation(Animation.easeInOut(duration: 1).repeatCount(1), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                    }
                    // MARK: - SPIN BUTTON AND BET BUTTON
                    HStack {
                        Button {
                            // NO ANIMATION
                            withAnimation{
                                self.animatingIcon = false
                            }
                            
                            // SPIN THE REELS
                            self.RollDices()
                            
                            // TRIGGER ANIMATION
                            withAnimation{
                                self.animatingIcon = true
                            }
                            
                            // CHECK WINNING
                            self.checkWinning()
                            
                            // GAME OVER
                            self.isGameOver()
                            validateBet = true
                        } label: {
                            Image("spinButton")
                                .resizable()
                                .modifier(ButtonModifier())
                                .frame(width: 150, height: 120, alignment: .center)
                        }
                        .disabled(validateBet)
                        Spacer()
                        Button {
                            if self.isChooseBetbutton == false {
                                self.isChooseBetbutton = true
                            } else if self.isChooseBetbutton == true {
                                self.isChooseBetbutton = false
                            }
                            
                            if betAmount != 0 && betAmount <= savedUsers[indexOfUser()].money && isChooseBetbutton == false {
                                if validateBet == true {
                                    validateBet = false
                                }
                            } else {
                                if validateBet == false {
                                    validateBet = true
                                }
                            }
                        } label: {
                            Image("betButton")
                                .resizable()
                                .modifier(ButtonModifier())
                                .frame(width: 150, height: 120, alignment: .center)
                        }
                    }
                    
                }
                
                
                // MARK: - FOOTER
                
                Spacer()
                
                HStack{
                    
                    HStack{
                        
                        // MARK: - BET HIGH BUTTON
                        Button {
                            self.chooseMax()
                        } label: {
                            HStack(spacing: 30){
                                Text("HIGH")
                                    .foregroundColor(isChooseMax ? Color("ColorBlueRMIT") : Color.white)
                                    .modifier(BetCapsuleModifier())
                               Image("casino-chips")
                                    .resizable()
                                    .offset(x: isChooseMax ? 0 : 20)
                                    .opacity(isChooseMax ? 1 : 0 )
                                    .modifier(CasinoChipModifier())
                                    .animation(.default, value: isChooseMax)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                        
                        // MARK: - BET LOW BUTTON
                        Button {
                            self.chooseMin()
                        } label: {
                            HStack(spacing: 30){
                                Image("casino-chips")
                                     .resizable()
                                     .offset(x: isChooseMin ? 0 : -20)
                                     .opacity(isChooseMin ? 1 : 0 )
                                     .modifier(CasinoChipModifier())
                                     .animation(.default, value: isChooseMin)
                                Text("LOW")
                                    .foregroundColor(isChooseMin ? Color("ColorBlueRMIT") : Color.white)
                                    .modifier(BetCapsuleModifier())
                               
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                }

            }
            .overlay(
                // MARK: - BACK TO USERS LIST BUTTON
                Button(action: {
                    self.isGoBackToUsersListView = true
                }) {
                  Image(systemName: "chevron.left.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topLeading
              )
            .overlay(
                
                // MARK: - INFO GAME BUTTON
                Button(action: {
                    self.showingInfoView = true
                }) {
                  Image(systemName: "info.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .overlay(
                
                // MARK: - RESET GAME BUTTON
                Button(action: {
                    self.resetGame()
                }) {
                  Image(systemName: "arrow.2.circlepath.circle")
                    .foregroundColor(.white)
                }
                .padding(.top, 45)
                .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
            
            
            
            // MARK: - GAMEOVER MODAL
            if showGameOverModal{
                ZStack{
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("GAME OVER")
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
                            Text("You lost all money!\nYou played so good!\n Good luck next time!")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.showGameOverModal = false
                                self.savedUsers[indexOfUser()].money = 1000
                            } label: {
                                Text("New Game".uppercased())
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
                }.onAppear(perform: {
                    playSound(sound: "drum-music", type: "mp3")
                  })
            }
            
            if isChooseBetbutton {
                ZStack {
                    VStack {
                        Spacer(minLength: 40)
                        Picker(selection: $betAmount, label: Text("Picker"), content: {
                            Text("10").tag(10)
                                .modifier(betNumberStyle())
                            Text("100").tag(100)
                                .modifier(betNumberStyle())
                            Text("1000").tag(1000)
                                .modifier(betNumberStyle())
                            Text("10000").tag(10000)
                                .modifier(betNumberStyle())
                        })
                        .pickerStyle(WheelPickerStyle())
                    }
                    .frame(minWidth: 250, idealWidth: 250, maxWidth: 300, minHeight: 150, idealHeight: 150, maxHeight: 170, alignment: .center)
                    .background(
                        Image("betWheelPicker")
                            .resizable()
                            .scaledToFit()
                    )
                    .cornerRadius(20)
                }
            }
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView(userInfo: savedUsers[indexOfUser()])
        }
    }
}
