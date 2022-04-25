//
//  CloudsView.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 23/04/22.
//

import Foundation
import SwiftUI

struct CloudsView: View {
    @State var cloudDrift: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 300, height: 200)
                .offset(x: cloudDrift + UIScreen.main.bounds.width/3)
            
            Spacer()
            
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 300, height: 200)
                .offset(x: cloudDrift + cloudDrift/3)
            
            Spacer()
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                cloudDrift -= UIScreen.main.bounds.width*2

            }
        }
    }
}
