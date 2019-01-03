//
//  GameOfLifeScene.swift
//  Make-School-Arrays
//
//  Created by Yujin Ariza on 2/21/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import SpriteKit

open class SimulationScene: SKScene {
    
    let gridPosition = CGPoint(x: 10.0, y: 100.0)
    let palettePosition = CGPoint(x: 10.0, y: 500.0)
    let playButtonPosition = CGPoint(x: 160.0, y: 10.0)
    let stepButtonPosition = CGPoint(x: 10.0, y: 10.0)
    let generationLabelPosition = CGPoint(x: 10.0, y: 470.0)
    
    internal var sim: Simulation!
    internal var palette: [Character?]!
    
    var grid: TouchableGrid!
    var paletteGrid: PaletteGrid!
    var playButton: MSPlayPauseToggleButtonNode!
    var stepButton: MSButtonNode!
    var generationLabel: SKLabelNode!
    
    var timer: Timer? = nil
    
    var liveChar: Character?
    
    var generation = 1
    
    internal func setup(simulation sim: Simulation, palette: [Character?]) {
        self.sim = sim
        sim.setup()
        self.palette = palette
    }
    
    open override func didMove(to view: SKView) {
        playButton = childNode(withName: "playButton") as! MSPlayPauseToggleButtonNode
        stepButton = childNode(withName: "stepButton") as! MSButtonNode
        playButton.selectedHandler = playPausePressed
        stepButton.selectedHandler = stepButtonPressed
        
        generationLabel = childNode(withName: "generationLabel") as! SKLabelNode
        
        grid = childNode(withName: "grid") as! TouchableGrid
        grid.setup(sim.grid)
        grid.touchCallback = gridCellTouched
        
        paletteGrid = childNode(withName: "palette") as! PaletteGrid
        paletteGrid.setup(palette)
        paletteGrid.touchCallback = paletteCellTouched
        
        if palette.count != 0 {
            liveChar = palette[0]
            paletteGrid.highlightCell(0)
        } else {
            liveChar = "👾"
        }
    }
    
    func gridCellTouched(_ x: Int, y: Int, moved: Bool) {
        if sim.grid[x][y] != liveChar {
            sim.grid[x][y] = liveChar
        } else {
            sim.grid[x][y] = nil
        }
        update()
    }
    
    func paletteCellTouched(_ x: Int, y: Int, moved: Bool) {
        paletteGrid.highlightCell(x)
        liveChar = palette[x]
    }
    
    func timerUpdate() {
        generation += 1
        generationLabel.text = "Generation: \(generation)"
        sim.update()
        update()
    }
    
    func playPausePressed() {
        if playButton.toggled {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SimulationScene.timerUpdate), userInfo: nil, repeats: true)
            timer?.fire()
        } else {
            timer?.invalidate()
        }
    }
    
    func stepButtonPressed() {
        timerUpdate()
    }
    
    func update() {
        grid.updateAll(sim.grid)
    }
}
