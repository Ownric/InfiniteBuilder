//
//  ObstaclesTutorial.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/22/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit


class ObstaclesTutorial: SKScene {
    /* UI Connections */
    var buttonTransitionThree: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonTransitionThree = self.childNodeWithName("buttonTransitionThree") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonTransitionThree.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = SpeedTutorial(fileNamed:"SpeedTutorial") as SpeedTutorial!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    }
}
