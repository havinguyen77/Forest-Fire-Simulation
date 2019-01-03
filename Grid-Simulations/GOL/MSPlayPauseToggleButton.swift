//
//  MSPlayPauseToggleButtonNode.swift
//  Grid-Simulations
//
//  Created by Dion Larson on 6/5/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

class MSPlayPauseToggleButtonNode: MSButtonNode {
    
    internal var toggled: Bool = false {
        didSet {
            if toggled {
                label.text = onText
            } else {
                label.text = offText
            }
        }
    }
    let offText = "Play"
    let onText = "Pause"
    let label = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        label.text = offText
        label.position = CGPoint(x: 0, y: 4)
        label.fontName = "Menlo Bold"
        label.fontSize = 32
        label.fontColor = SKColor(red: 0, green: 43.0/255, blue: 62.0/255, alpha: 1.0)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        self.addChild(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggled = !toggled
        super.touchesEnded(touches, with: event)
    }
    
}
