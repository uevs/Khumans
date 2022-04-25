//
//  GameView.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 20/04/22.
//


import SwiftUI
import AVKit

struct GameView: View {
    
    @ObservedObject var character = Character(roof: -150, floor: 0)
    @ObservedObject var state = AppState()
    
    @State var musicPlayer: AVAudioPlayer?
    @State var disabled: Bool = true
    @State var darkAndGray: Double = 0
    @State var packOffset: Double = -UIScreen.main.bounds.width
    @State var fadeToBlack: Double = 0
        
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.teal, .cyan]), startPoint: .bottomLeading, endPoint: .topTrailing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            CloudsView()
           
            Group {
                Image("paper")
                    .resizable()
                    .ignoresSafeArea()
                    .blendMode(.multiply)

                Color.black
                    .ignoresSafeArea()
                    .blendMode(.hue)
                    .opacity(darkAndGray)
                
                Color.black
                    .ignoresSafeArea()
                    .opacity(darkAndGray/3)
            }
            
            VStack {
                Spacer()

                Spacer()
                
                ZStack {
                    BirdView(bird: "\(state.bird)")
                        .offset(y: character.height)
                    PackView()
                        .offset(x: packOffset)
                        .opacity(state.stage < 18 ? 0 : 1)
                    CloudsView()
                        .opacity(0.5)
                        .offset(x: 100)
                }
                .frame(height: UIScreen.main.bounds.height/2)
                .padding(.top)
            }
            .zIndex(100)
            
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(state.stage < 18 ? character.height/(UIScreen.main.bounds.height/2) : 0)
                .zIndex(101)

            VStack {
                Spacer()
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("TAP!")
                        .multilineTextAlignment(.center)
                        .font(.title)
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .offset(x: -150)
                .padding()
                .opacity(character.height > 200 ? 1 : 0)
            }
            .zIndex(102)
   
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(fadeToBlack)
                .zIndex(200)
            
            HStack {
                Spacer()
                Button {
                    state.next = false
                    state.stage = state.currentText + 1
                    state.update()
                    switchStages()
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(state.next ? .white : .clear)
                }
                .padding(50)
                .disabled(!state.next)
            }
            .zIndex(300)

            VStack {
                Spacer()
                
                Text("\(state.text[state.currentText])")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .shadow(color: .black, radius: 1, x: -1, y: -1)
                    .padding()
                    .padding(.horizontal, 40)
                
                Spacer()
                
                Spacer()
                
                Spacer()
                
                Spacer()
            }
            .zIndex(300)
            
            Group {
                if state.stage >= 21 {
                Text("Talk to your friends and loved ones if you feel something is off.")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .offset(y: -100)
                }
                
                if state.stage >= 22 {
                    Text("Don't be afraid to seek professional help if you are struggling, things will get better.")
                        .font(.largeTitle).bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                    
                    Text("Created by Leonardo Bertinelli for WWDC22 Swift Student Challenge.\nMusic Melancholic Ending by Soft and Furious is licensed under a CC0 1.0 Universal License (Public Domain).\nBeauty is everywhere if you know how to look.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .offset(y: UIScreen.main.bounds.height/3)
                }
            }
            .zIndex(400)
        }
        .onAppear {
            musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            musicPlayer?.play()
            musicPlayer?.numberOfLoops = -1
        }
        .onAnimationCompleted(for: character.height) {
            if character.height < character.floor {
                withAnimation(.linear) {
                    character.height += character.fallSpeed
                }
            }
        }
        .onTapGesture {
            state.step()
            
            if character.height > character.roof {
                withAnimation {
                    character.height -= character.jump
                }
            }
        }
    }

    func switchStages() {
        if state.stage == 2 {
            character.floor = UIScreen.main.bounds.height/3
            withAnimation() {
                character.height = character.height-10
            }
        } else if state.stage == 5 {
            character.roof = -UIScreen.main.bounds.height/3
            character.fallSpeed = 20
            character.jump = 100
        } else if state.stage == 6 {
            character.fallSpeed = 70
            character.jump = 20
        } else if state.stage == 11 {
            withAnimation(.linear(duration: 10)) {
                darkAndGray = 1
            }
            if character.height < 0 {
                withAnimation(.linear(duration: 1)) {
                    character.height = 0
                }
            }
            character.fallSpeed = 100
            character.jump = 5
        } else if state.stage == 16 {
            withAnimation() {
                darkAndGray = 0
            }
        } else if state.stage == 18 {
            character.fallSpeed = 60

            withAnimation(.easeOut(duration: 1)) {
                packOffset = 0
            }
            withAnimation(.linear(duration: 1)) {
                character.height = 0
            }
            character.floor = 0
        } else if state.stage == 20 {
            withAnimation(.linear(duration: 1)) {
                fadeToBlack = 1
            }
        }
    }
}


struct AnimationEndChecker<Value>: AnimatableModifier where Value: VectorArithmetic {
   
    var target: Value
    var finish: () -> Void
    var animatableData: Value {
        didSet {
            notifyFinish()
        }
    }
    
    init(observed: Value, completion: @escaping () -> Void) {
        self.finish = completion
        self.animatableData = observed
        target = observed
    }
    
    func notifyFinish() {
        guard animatableData == target else { return }
        DispatchQueue.main.async {
            self.finish()
        }
    }
    
    func body(content: Content) -> some View {
        return content
    }
}

extension View {
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationEndChecker<Value>> {
        return modifier(AnimationEndChecker(observed: value, completion: completion))
    }
}
