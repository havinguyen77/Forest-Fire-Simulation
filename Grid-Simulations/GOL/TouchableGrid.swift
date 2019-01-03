//
//  TouchableGrid.swift
//  Make-School-Arrays
//
//  Created by Yujin Ariza on 3/4/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

open class TouchableGrid: SKSpriteNode {
    
    var map: [[SKLabelNode?]]!
    var shapeMap: [[SKShapeNode]]!
    var overlayTextMap: [[SKLabelNode?]]!
    var width: Int {
        return map.count
    }
    
    var height: Int {
        return (map.count != 0) ? map[0].count : 0
    }
    
    let tileSize: CGFloat = 76
    open var touchCallback: ((Int, Int, Bool) -> Void)? = nil
    
    open var textDefaultColor = UIColor.white
    open var tileDefaultColor = UIColor.clear
    open var textIncorrectColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 1.0)
    open var tileIncorrectColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 1.0)
    open var tileDefaultLineWidth: CGFloat = 1.0
    open var tileDefaultLineColor = UIColor.black
    let verticalOffset: CGFloat = 16
    
    func setup(_ charMap: [[Character?]]) {
        self.isUserInteractionEnabled = true
        
        if (charMap.count != 0) {
            map = [[SKLabelNode?]].init(repeating: [SKLabelNode?].init(repeating: nil, count: charMap[0].count),
                count: charMap.count)
            overlayTextMap = [[SKLabelNode?]].init(repeating: [SKLabelNode?].init(repeating: nil, count: charMap[0].count),
                count: charMap.count)
        } else {
            map = []
            overlayTextMap = []
        }
        
        shapeMap = []

        for x in 0..<width {
            var col: [SKShapeNode] = []
            for y in 0..<height {
                let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: tileSize, height: tileSize))
                shape.lineWidth = 0
                shape.position = CGPoint(x: CGFloat(x)*tileSize, y: CGFloat(y)*tileSize + verticalOffset)
                shape.zPosition = 10
                col.append(shape)
                self.addChild(shape)
            }
            shapeMap.append(col)
        }
        updateAll(charMap)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.location(in: self)
            let x = Int(touchPosition.x / tileSize)
            let y = Int((touchPosition.y - verticalOffset) / tileSize)
            if 0 <= x && x < width &&
                0 <= y && y < height {
                if let touchCallback = touchCallback {
                    touchCallback(x, y, false)
                }
            }
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.location(in: self)
            let x = Int(touchPosition.x / tileSize)
            let y = Int((touchPosition.y - verticalOffset) / tileSize)
            if 0 <= x && x < width &&
                0 <= y && y < height {
                if let touchCallback = touchCallback {
                    touchCallback(x, y, true)
                }
            }
        }
    }

    open func updateAll(_ map: [[Character?]]) {
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                setCell(i, y: j, char: map[i][j])
            }
        }
    }
    
    func labelFactory(_ char: String, x: Int, y: Int) -> SKLabelNode {
        let newLabel = SKLabelNode(text: String(char))
        newLabel.verticalAlignmentMode = .baseline
        newLabel.horizontalAlignmentMode = .center
        newLabel.fontSize = 54.0
        newLabel.fontName = "Menlo Bold"
        let baselineOffest: CGFloat = 14.0
        newLabel.position = CGPoint(x: (CGFloat(x)+0.5) * tileSize, y: (CGFloat(y)) * tileSize + verticalOffset + baselineOffest)
        newLabel.zPosition = 10
        return newLabel
    }
    
    open func setCell(_ x: Int, y: Int, char: Character?) {
        let label = map[x][y]
        if let label = label {
            if char == nil {
                label.removeFromParent()
                map[x][y] = nil
            } else if label.text != String(char!) {
                label.text = String(char!)
            }
        } else {
            if let char = char {
                let newLabel = labelFactory(String(char), x: x, y: y)
                self.addChild(newLabel)
                map[x][y] = newLabel
            }
        }
    }
    
    open func setOverlayText(_ x: Int, _ y: Int, text: String?, color: UIColor) {
        let label = overlayTextMap[x][y]
        if let label = label {
            if let text = text {
                label.text = text
                label.fontColor = color
            } else {
                label.removeFromParent()
                overlayTextMap[x][y] = nil
            }
        } else {
            if let text = text {
                let newLabel = labelFactory(text, x: x, y: y)
                self.addChild(newLabel)
                map[x][y] = newLabel
            }
        }
    }
    
    public enum TileState {
        case `default`
        case incorrect
    }
    
    open func setTileState(_ x: Int, _ y: Int, state: TileState) {
        let shape = shapeMap[x][y]
        let label = map[x][y]
        switch state {
        case .default:
            if let label = label {
                label.fontColor = textDefaultColor
            }
            shape.fillColor = tileDefaultColor
        case .incorrect:
            if let label = label {
                label.fontColor = textIncorrectColor
            } else {
                shape.fillColor = tileIncorrectColor
            }
        }
    }
}
