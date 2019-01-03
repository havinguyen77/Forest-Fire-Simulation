//
//  ForestFireSimulation.swift
//  Grid-Simulations
//
//  Created by Havi Nguyen
//

import Foundation

public class ForestFireSimulation: Simulation {
    
    var newGrid: [[Character?]] = []
    public override func setup() {
        grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
        for x in 0..<grid.count{
            for y in 0..<grid[0].count{
                if randomZeroToOne() < 0.05{
                    grid[x][y] = "🌳"
                }
                if randomZeroToOne() < 0.05{
                    grid[x][y] = "🌱"
                }
            }
        }
    }
    func thunderboltAndLightning() {
        newGrid = grid
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                if grid[x][y] == nil {
                    if randomZeroToOne() < 0.003{
                        newGrid[x][y] = "🌲"
                    }                }
                if grid[x][y] == "🌲"{
                    let neighCord = getNeighborPositions(x: x, y: y)
                    for neighborsAround in neighCord{
                        let neighbor = grid[neighborsAround.x][neighborsAround.y]
                        if neighbor == "🔥"{
                            newGrid[x][y] = "🔥"
                        }
                        else if randomZeroToOne() < 0.001{
                            newGrid[x][y] = "🔥"
                        }
                    }
                }
                if grid [x][y] == "🔥"{
                    newGrid[x][y] = nil
                }
                grid = newGrid
            }
        }
    }
    
    func aTinyForest() {
        newGrid = grid
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                if grid[x][y] == nil {
                    if randomZeroToOne() < 0.001{
                        newGrid[x][y] = "🌲"
                    }
                }
                if grid[x][y] == "🌲"{
                    let neighCord = getNeighborPositions(x: x, y: y)
                    for neighborsAround in neighCord{
                        let neighbor = grid[neighborsAround.x][neighborsAround.y]
                        if neighbor == "🔥"{
                            newGrid[x][y] = "🔥"
                        }
                    }
                }
                if grid [x][y] == "🔥"{
                    newGrid[x][y] = nil
                }
                
                grid = newGrid
            }
        }
    }
    func noMercy(){
        newGrid = grid
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                if grid[x][y] == nil {
                    if randomZeroToOne() < 0.001{
                        newGrid[x][y] = "🌲"
                    }
                }
                if grid[x][y] == "🌲"{
                    let neighCord = getNeighborPositions(x: x, y: y)
                    for neighborsAround in neighCord{
                        let neighbor = grid[neighborsAround.x][neighborsAround.y]
                        if neighbor == "🔥"{
                            newGrid[x][y] = "🔥"
                        }
                        else if neighbor == "✂️"{
                            newGrid[x][y] = nil
                        }
                        else if randomZeroToOne() < 0.001{
                            newGrid[x][y] = "🔥"
                        }
                    }
                }
                if grid [x][y] == "🔥"{
                    newGrid[x][y] = nil
                }
                grid = newGrid
            }
        }
    }
    func jerkTree(){
        newGrid = grid
        for x in 0..<grid.count{
            for y in 0..<grid[0].count{
                if grid[x][y] == nil{
                    if randomZeroToOne() < 0.005{
                        newGrid[x][y] = "🌳"
                    }
                    if randomZeroToOne() < 0.01{
                        newGrid[x][y] = "🌱"
                    }
                }
                if grid[x][y] == "🌳"{
                    let neighCord = getNeighborPositions(x: x, y: y)
                    var weedCounter: Int = 0
                    for neighborsAround in neighCord{
                        let neighbor = grid[neighborsAround.x][neighborsAround.y]
                        if neighbor == "✂️"{
                            newGrid[x][y] = nil
                        }
                        if neighbor == "🌱"{
                            weedCounter += 1
                        }
                        if weedCounter >= 4{
                            newGrid[x][y] = nil
                        }
                    }
                }
                if grid[x][y] == "🌱"{
                    let neighCord = getNeighborPositions(x: x, y: y)
                    for neighborsAround in neighCord{
                        let neighbor = grid[neighborsAround.x][neighborsAround.y]
                        if neighbor == "🔥"{
                            newGrid[x][y] = "🔥"
                        }
                        else if neighbor == "✂️"{
                            newGrid[x][y] = nil
                        }
                        else if randomZeroToOne() < 0.001{
                            newGrid[x][y] = "🔥"
                        }
                    }
                }
                if grid [x][y] == "🔥"{
                    newGrid[x][y] = nil
                }
                grid = newGrid
            }
        }
    }
    public override func update() {
        jerkTree()
    }
    func isLegalPosition(x: Int, y: Int) -> Bool {
        if ((x < grid.count && x >= 0) && ( y < grid[0].count && y >= 0)) {
            return true
        }
        else{
            return false
        }
    }
 
    func getNeighborPositions(x originX: Int, y originY: Int) -> [(x: Int, y: Int)]{
        var neighbors: [(x:Int, y:Int)] = []
        for x in (originX - 1)...(originX + 1){
            for y in (originY - 1)...(originY + 1){
                if isLegalPosition(x: x, y: y){
                    if !( x == originX && y == originY){
                        neighbors.append((x, y))
                    }
                }
            }
            
        }
      return neighbors
    
    }
 
}

