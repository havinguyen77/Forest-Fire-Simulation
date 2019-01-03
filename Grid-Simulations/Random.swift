//
//  Random.swift
//  Grid-Simulations
//
//  Created by Dion Larson on 6/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public func randomZeroToOne() -> Double {
    return Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
}
