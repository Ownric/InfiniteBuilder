//
//  GreetingsTutorialScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/21/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class GreetingsTutorial: SKScene {
    
    /* UI Connections */
    var buttonTransitionOne: MSButtonNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonTransitionOne = self.childNodeWithName("buttonTransitionOne") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonTransitionOne.selectedHandler = {
            
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
    }
}
