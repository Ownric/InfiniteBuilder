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
    
    var slowBack: SKSpriteNode!
    
    var mediumBack: SKSpriteNode!
    
    var fastBack: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonSpeedFast = self.childNodeWithName("buttonSpeedFast") as! MSButtonNode
        
        buttonSpeedMedium = self.childNodeWithName("buttonSpeedMedium") as! MSButtonNode
        
        buttonSpeedSlow = self.childNodeWithName("buttonSpeedSlow") as! MSButtonNode
        
        slowBack = self.childNodeWithName("slowBack") as! SKSpriteNode
        
        mediumBack = self.childNodeWithName("mediumBack") as! SKSpriteNode
        
        fastBack = self.childNodeWithName("fastBack") as! SKSpriteNode
        
        if self.selectWhatever.scrollSpeed == 240 {
            self.slowBack.color = .greenColor()
            self.mediumBack.color = .blueColor()
            self.fastBack.color = .blueColor()
        }
        if self.selectWhatever.scrollSpeed == 280 {
            self.slowBack.color = .blueColor()
            self.mediumBack.color = .greenColor()
            self.fastBack.color = .blueColor()
        }
        if self.selectWhatever.scrollSpeed == 320 {
            self.slowBack.color = .blueColor()
            self.mediumBack.color = .blueColor()
            self.fastBack.color = .greenColor()
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        buttonSpeedFast.selectedHandler = {
            self.selectWhatever.scrollSpeed = 320
            
            self.slowBack.color = .blueColor()
            self.mediumBack.color = .blueColor()
            self.fastBack.color = .greenColor()
        }
        buttonSpeedMedium.selectedHandler = {
            self.selectWhatever.scrollSpeed = 280
            
            self.slowBack.color = .blueColor()
            self.mediumBack.color = .greenColor()
            self.fastBack.color = .blueColor()
        }
        buttonSpeedSlow.selectedHandler = {
            self.selectWhatever.scrollSpeed = 240
            
            self.slowBack.color = .greenColor()
            self.mediumBack.color = .blueColor()
            self.fastBack.color = .blueColor()
        }
    }
}
