//
//  PackView.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 23/04/22.
//

import Foundation
import SwiftUI

struct PackView: View {
    var body: some View {
        HStack {
            BirdView(bird: "bird1")
                .offset(y: 100)
            BirdView(bird: "bird2")
                .offset(y: 120)
            BirdView(bird: "bird3")
                .offset(y: 90)
            BirdView(bird: "bird5")
                .offset(y: 110)
            BirdView(bird: "bird6")
                .offset(y: 90)
            BirdView(bird: "bird7")
                .offset(y: 130)
            BirdView(bird: "bird8")
                .offset(y: 70)

        }
    }
}

