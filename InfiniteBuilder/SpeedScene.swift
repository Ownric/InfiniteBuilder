//
//  SpeedScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class SpeedScene: SKScene {
    
    enum speedType{
        case Fast, Medium, Slow
    }
    
    var currentSpeedType: speedType = .Slow
    
    /* UI Connections */
    var buttonReturn: MSButtonNode!
    
    var buttonSpeedFast: MSButtonNode!
    
    var buttonSpeedMedium: MSButtonNode!
    
    var buttonSpeedSlow: MSButtonNode!
    
    var selectWhatever: SelectScene!
    
    var slowCheck: SKSpriteNode!
    
    var mediumCheck: SKSpriteNode!
    
    var fastCheck: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonSpeedFast = self.childNodeWithName("buttonSpeedFast") as! MSButtonNode
        
        buttonSpeedMedium = self.childNodeWithName("buttonSpeedMedium") as! MSButtonNode
        
        buttonSpeedSlow = self.childNodeWithName("buttonSpeedSlow") as! MSButtonNode
        
        slowCheck = self.childNodeWithName("slowCheck") as! SKSpriteNode
        
        mediumCheck = self.childNodeWithName("mediumCheck") as! SKSpriteNode
        
        fastCheck = self.childNodeWithName("fastCheck") as! SKSpriteNode
        
        if self.selectWhatever.scrollSpeed == 240 {
            self.slowCheck.alpha = 1
            self.mediumCheck.alpha = 0
            self.fastCheck.alpha = 0
        }
        if self.selectWhatever.scrollSpeed == 300 {
            self.slowCheck.alpha = 0
            self.mediumCheck.alpha = 1
            self.fastCheck.alpha = 0
        }
        if self.selectWhatever.scrollSpeed == 360 {
            self.slowCheck.alpha = 0
            self.mediumCheck.alpha = 0
            self.fastCheck.alpha = 1
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        buttonSpeedFast.selectedHandler = {
            self.selectWhatever.scrollSpeed = 360
            self.selectWhatever.speedType = 360
            
            self.slowCheck.alpha = 0
            self.mediumCheck.alpha = 0
            self.fastCheck.alpha = 1
        }
        buttonSpeedMedium.selectedHandler = {
            self.selectWhatever.scrollSpeed = 300
            self.selectWhatever.speedType = 300
            
            self.slowCheck.alpha = 0
            self.mediumCheck.alpha = 1
            self.fastCheck.alpha = 0
        }
        buttonSpeedSlow.selectedHandler = {
            self.selectWhatever.scrollSpeed = 240
            self.selectWhatever.speedType = 240
            
            self.slowCheck.alpha = 1
            self.mediumCheck.alpha = 0
            self.fastCheck.alpha = 0
        }
    }
}
