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
    
    var selectWhatever: SelectScene!
    
    var buttonControlFlappy: MSButtonNode!
    
    var buttonControlJetPack: MSButtonNode!
    
    var jetpackBack: SKSpriteNode!
    
    var flappyBack: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonControlFlappy = self.childNodeWithName("buttonControlFlappy") as! MSButtonNode
        
        buttonControlJetPack = self.childNodeWithName("buttonControlJetPack") as! MSButtonNode
        
        jetpackBack = self.childNodeWithName("jetpackBack") as! SKSpriteNode
        
        flappyBack = self.childNodeWithName("flappyBack") as! SKSpriteNode
        
        if self.selectWhatever.controlType == 1 {
            self.jetpackBack.color = .blueColor()
            self.flappyBack.color = .greenColor()
        }
        if self.selectWhatever.controlType == 0 {
            self.jetpackBack.color = .greenColor()
            self.flappyBack.color = .blueColor()
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        
        buttonControlJetPack.selectedHandler = {
            self.selectWhatever.controlType = 0
            self.jetpackBack.color = .greenColor()
            self.flappyBack.color = .blueColor()
        }
        
        buttonControlFlappy.selectedHandler = {
            self.selectWhatever.controlType = 1
            self.jetpackBack.color = .blueColor()
            self.flappyBack.color = .greenColor()
        }
    }
}