//
//  BirdView.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 23/04/22.
//

import Foundation
import SwiftUI

struct BirdView: View {
    @State var floatY: CGFloat = 20
    @State var floatX: CGFloat = -5
    @State var angle: Angle = Angle.degrees(10)
    
    var bird: String
    
    var body: some View {
        Image(bird)
            .resizable()
            .offset(x: floatX, y: floatY)
            .rotationEffect(angle, anchor: .center)
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .onAppear {
                withAnimation(.linear(duration: 0.5).repeatForever()) {
                    floatY = 0
                    floatX.negate()
                }
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    angle = Angle(degrees: 0)
                }
            }
    }
}
