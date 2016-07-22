//
//  SpeedTutorial.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/22/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit


class SpeedTutorial: SKScene {
    /* UI Connections */
    var buttonTransitionFour: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonTransitionFour = self.childNodeWithName("buttonTransitionFour") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonTransitionFour.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
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