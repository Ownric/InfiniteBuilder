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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonSpeedFast = self.childNodeWithName("buttonSpeedFast") as! MSButtonNode
        
        buttonSpeedMedium = self.childNodeWithName("buttonSpeedMedium") as! MSButtonNode
        
        buttonSpeedSlow = self.childNodeWithName("buttonSpeedSlow") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        buttonSpeedFast.selectedHandler = {
            self.selectWhatever.scrollSpeed = 280
        }
        buttonSpeedMedium.selectedHandler = {
            self.selectWhatever.scrollSpeed = 240
        }
        buttonSpeedSlow.selectedHandler = {
            self.selectWhatever.scrollSpeed = 200
        }
    }
}
