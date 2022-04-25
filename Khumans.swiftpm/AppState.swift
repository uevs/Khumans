//
//  AppState.swift
//  Khumans
//
//  Created by Leonardo Bertinelli on 20/04/22.
//

import Foundation

class AppState: ObservableObject {
    
    @Published var next: Bool = true
    @Published var steps: Int = 1
    @Published var currentText: Int = 0
    @Published var bird: String = "bird1"
    @Published var end: Bool = false
    var stage: Int = 0
    
    let text = [
        "Flying is a natural talent for all Khumans.",
        "They can just do it.",
        "(Tap the screen to fly.\nDon't let the Khuman fall!)",
        "But this doesn’t mean everyone does it the same way.",
        "Every Khuman is different.",
        "For most Khumans flying is a smooth ride, easily carried by the wind.",
        "For others it’s more complicated, it requries some effort.",
        "Maybe they are distracted by something shiny so they can’t focus on flying.",
        "Maybe they are a bit sad.",
        "Maybe they are a bit angry.",
        "But they still fly.",
        "Unfortunately, sometimes the mind of a Khuman can go in the wrong direction.",
        "And then even something that should be simple and natural as flying becomes a hard task.",
        "Fatiguing.",
        "They feel like having a rope tied to their body, pulling them down.",
        "Just surviving drains them of all their energy.",
        "But you would never know by watching them from the outside.",
        "You would just see a Khuman flying, without understanding their struggle.",
        "This is why Khumans learned to fly together.",
        "To ensure no one is left behind.",
        "Depression sometimes can be invisibile from the outside.",
        "Depression sometimes can be invisibile from the outside."]
    
    func step() {
        if !next {
            update()
            steps += 1
        }
    }
    
    func check(_ goal: Int) {
        if steps < goal {
            next = false
        } else {
            next = true
            steps = 0
        }
    }
    
    func update() {
        
        if stage <= 1 {
            currentText = stage
            next = true
        } else if stage >= 2 && stage <= 4 {
            switch steps {
            case 1:
                currentText = 2
            case 10 :
                currentText = 3
            case 20:
                currentText = 4
            default:
                break
            }
            check(30)
        } else if stage == 5 {
            // Smooth ride
            bird = "bird2"
            currentText = stage
            check(15)
        } else if stage >= 6 && stage <= 10 {
            // Some effort
            bird = "bird3"
            switch steps {
            case 1:
                currentText = 6
            case 15:
                currentText = 7
            case 25:
                currentText = 8
            case 35:
                currentText = 9
            case 45:
                currentText = 10
            default:
                break
            }
            check(50)
        } else if stage >= 11 && stage <= 13 {
            // Depression
            bird = "bird4"
            switch steps {
            case 1:
                currentText = 11
            case 50:
                currentText = 12
            case 100:
                currentText = 13
            default:
                break
            }
            check(150)
        } else if stage >= 14 && stage <= 15 {
            // Depression2
            switch steps {
            case 1:
                currentText = 14
            case 25:
                currentText = 15
            default:
                break
            }
            check(50)
        } else if stage >= 16 && stage <= 17 {
            // Outside view
            switch steps {
            case 1:
                currentText = 16
            case 20:
                currentText = 17
            default:
                break
            }
            check(40)
        } else if stage >= 18 && stage <= 19 {
            // Pack
            currentText = stage
            next = true
        } else if stage == 20  {
            // Closing
            currentText = stage
            next = true
        } else if stage == 21 {
            // Replay
            currentText = stage
            next = true
         }else if stage >= 22 {
            // Replay
            next = false
             end = true
        }
    }
}




