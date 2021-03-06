//
//  MainScene.swift
//  PeevedPenguins
//
//  Created by Owen Meyer on 6/24/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    /* UI Connections */
    var buttonPlay: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonPlay = self.childNodeWithName("buttonPlay") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonPlay.selectedHandler = {
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = SelectScene(fileNamed:"SelectScene") as SelectScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    }
}