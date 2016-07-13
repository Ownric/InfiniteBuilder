//
//  SpeedScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class SpeedScene: SKScene {
    
    /* UI Connections */
    var buttonReturn: MSButtonNode!
    
    var buttonSpeedFast: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonSpeedFast = self.childNodeWithName("buttonSpeedFast") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = SelectScene(fileNamed:"SelectScene") as SelectScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        buttonSpeedFast.selectedHandler = {
            GameScene.valueForKey("scrollSpeed") = 300
        }
    }
}
