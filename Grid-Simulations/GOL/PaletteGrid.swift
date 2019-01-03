//
//  PaletteGrid.swift
//  Make-School-Arrays
//
//  Created by Yujin Ariza on 3/4/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

open class PaletteGrid: TouchableGrid {
    
    var highlighted: Int? = nil
    
    open var tileHighlightedLineWidth: CGFloat = 2.0
    open var tileHighlightedLineColor = UIColor.white
    
    internal func setup(_ paletteArray: [Character?]) {
        let map = PaletteGrid.arrayToMap(paletteArray)
        super.setup(map)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func updateAll(_ palette: [Character?]) {
        updateAll(PaletteGrid.arrayToMap(palette))
    }
    
    open func highlightCell(_ x: Int) {
        if let highlighted = highlighted {
            if x != highlighted {
                let cell = self.shapeMap[highlighted][0]
                cell.lineWidth = tileDefaultLineWidth
                cell.strokeColor = tileDefaultLineColor
                cell.zPosition = 0
            }
            let cell = self.shapeMap[x][0]
            cell.lineWidth = tileHighlightedLineWidth
            cell.strokeColor = tileHighlightedLineColor
            cell.zPosition = 0.5
            self.highlighted = x
        }
    }
    
    open static func arrayToMap(_ palette: [Character?]) -> [[Character?]] {
        var map: [[Character?]] = []
        for char in palette {
            map.append([char])
        }
        return map
    }
}
