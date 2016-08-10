//
//  ControlsScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class ControlsScene: SKScene {
    
    /* UI Connections */
    var buttonReturn: MSButtonNode!
    
    weak var selectWhatever: SelectScene!
    
    var buttonControlFlappy: MSButtonNode!
    
    var buttonControlJetPack: MSButtonNode!
    
    var gliderCheck: SKSpriteNode!
    
    var airHopCheck: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonControlFlappy = self.childNodeWithName("buttonControlFlappy") as! MSButtonNode
        
        buttonControlJetPack = self.childNodeWithName("buttonControlJetPack") as! MSButtonNode
        
        gliderCheck = self.childNodeWithName("gliderCheck") as! SKSpriteNode
        
        airHopCheck = self.childNodeWithName("airHopCheck") as! SKSpriteNode
        
        let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
        self.runAction(touchSFX)
        
        if self.selectWhatever.controlType == 1 {
            self.gliderCheck.alpha = 0
            self.airHopCheck.alpha = 1
        }
        if self.selectWhatever.controlType == 0 {
            self.gliderCheck.alpha = 1
            self.airHopCheck.alpha = 0
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            self.selectWhatever.buttonsPressed[0] = 0
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        
        buttonControlJetPack.selectedHandler = {
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            self.selectWhatever.controlType = 0
            self.gliderCheck.alpha = 1
            self.airHopCheck.alpha = 0
        }
        
        buttonControlFlappy.selectedHandler = {
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            self.selectWhatever.controlType = 1
            self.gliderCheck.alpha = 0
            self.airHopCheck.alpha = 1
        }
    }
}