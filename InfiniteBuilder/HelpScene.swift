//
//  HelpScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/25/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class HelpScene: SKScene {
    
    /* UI Connections */
    var buttonDone: MSButtonNode!
    
    weak var selectWhatever: SelectScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonDone = self.childNodeWithName("buttonDone") as! MSButtonNode
        
        let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
        self.runAction(touchSFX)
        
        /* Setup restart button selection handler */
        buttonDone.selectedHandler = {
            
            self.selectWhatever.buttonsPressed[4] = 0
            
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
            skView.presentScene(self.selectWhatever)
        }
    }
}
