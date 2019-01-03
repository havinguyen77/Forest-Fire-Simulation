//
//  Simulation.swift
//  Make-School-Arrays
//
//  Created by Yujin Ariza on 3/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

open class Simulation {
    open var grid: [[Character?]]
    
    public init() {
        grid = []
    }
    
    public init(other: Simulation) {
        grid = other.grid
    }
    
    public init?(file: String) {
        grid = []
        if let temp = readFromFile(file) {
            grid = temp
        } else {
            return nil
        }
    }
    
    fileprivate func readFromFile(_ file: String) -> [[Character?]]? {
        let nullChar: Character = "0"
        let reader = StreamReader(path: file)
        if let reader = reader {
            var grid: [[Character?]] = []
            var rowLength = 0
            while let line = reader.nextLine() {
                if grid.count == 0 {
                    rowLength = line.characters.count
                    grid = [[Character?]].init(repeating: [], count: rowLength)
                }
                if line.characters.count != rowLength {
                    // something is wrong
                    print("expected line length of \(rowLength), got length of \(line.characters.count)")
                    return nil
                }
                for i in 0..<rowLength {
                    let char = line[line.characters.index(line.startIndex, offsetBy: i)]
                    if char == nullChar {
                        grid[i].append(nil)
                    } else {
                        grid[i].append(char)
                    }
                }
            }
            return grid
        } else {
            return nil
        }
    }

    open func setup() {
    }
    
    open func update() {
    }
}
