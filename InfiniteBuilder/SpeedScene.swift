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
    
    var selectWhatever: SelectScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonSpeedFast = self.childNodeWithName("buttonSpeedFast") as! MSButtonNode
        
        buttonSpeedMedium = self.childNodeWithName("buttonSpeedMedium") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Start game scene */
            skView.presentScene(self.selectWhatever)
        }
        
        buttonSpeedFast.selectedHandler = {
            
            self.selectWhatever.scrollSpeed = 400.0
            
        }
        
        buttonSpeedMedium.selectedHandler = {
        }
    }
    
}
