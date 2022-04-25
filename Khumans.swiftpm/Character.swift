//
//  Character.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 20/04/22.
//

import Foundation
import SwiftUI

class Character: ObservableObject {
    @Published var fallSpeed: CGFloat
    @Published var jump: Double
    @Published var roof: CGFloat = -200
    @Published var floor: CGFloat = 100
    @Published var height: CGFloat = 0
    
    init(fallSpeed: CGFloat = 50, jump: Double = 100, roof: CGFloat = -200, floor: CGFloat = 100) {
        self.fallSpeed = fallSpeed
        self.jump = jump
        self.roof = roof
        self.floor = floor
    }
}

