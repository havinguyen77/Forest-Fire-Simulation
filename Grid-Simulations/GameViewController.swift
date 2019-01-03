//
//  GameViewController.swift
//  Make-School-Arrays
//
//  Created by Yujin Ariza on 2/21/16.
//  Copyright (c) 2016 Make School. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "map01", ofType: "txt")!
        
        ///////////////////////////////////////
        // ForestFireSimulation setup start //
        /////////////////////////////////////
        
       let sim = ForestFireSimulation()
       let palette: [Character?] = ["🔥", "🌳", "✂️", "🌱", nil, nil, nil, nil]
        
        /////////////////////////////////////
        // ForestFireSimulation setup end //
        ///////////////////////////////////
        
        let scene = SimulationScene(fileNamed: "SimulationScene")!
        scene.setup(simulation: sim, palette: palette)
        
        let skView = self.view as! SKView
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }

    override var shouldAutorotate : Bool {
        return false
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data & images that are not in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
