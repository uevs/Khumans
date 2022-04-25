//
//  ContentView.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 20/04/22.
//


import SwiftUI

struct ContentView: View {
    @State var intro: Bool = true
    
    var body: some View {
        
        
        if intro {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.teal, .cyan]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                Image("paper")
                    .resizable()
                    .ignoresSafeArea()
                    .blendMode(.multiply)
                
                VStack {
                    HStack {
                        Image(systemName: "ipad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .overlay(Image(systemName: "multiply").resizable().foregroundColor(.red).frame(width:30, height:30))
                        
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotation3DEffect(Angle(degrees: 90), axis: (x:0,y:0,z:1))
                            .frame(width: 50, height: 50)
                            .padding()

                        Image(systemName: "ipad.landscape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .overlay(Image(systemName: "checkmark").resizable().foregroundColor(.green).frame(width:30, height:30))
                    }
                    .foregroundColor(.white)
                    
                    Text("Rotate your iPad in landscape mode and turn up the volume \(Image(systemName: "speaker.wave.3")) before playing.")
                        .font(.title).bold()
                        .foregroundColor(.white)
                        .padding()
                    Button {
                        intro = false
                    } label: {
                        Image(systemName: "play.circle")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    
                }
            }
        } else if !intro {
            GameView()
        }
    }
}
