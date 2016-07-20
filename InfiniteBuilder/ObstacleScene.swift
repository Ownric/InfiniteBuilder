//
//  ObstacleScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class ObstacleScene: SKScene {
    
    /* UI Connections */
    var buttonReturn: MSButtonNode!
    
    var buttonGoal: MSButtonNode!
    
    var buttonSpikeWall: MSButtonNode!
    
    var buttonFunnel: MSButtonNode!
    
    var selectWhatever: SelectScene!
    
    var goalBack: SKSpriteNode!
    
    var spikeWallBack: SKSpriteNode!
    
    var funnelBack: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonGoal = self.childNodeWithName("buttonGoal") as! MSButtonNode
        
        buttonSpikeWall = self.childNodeWithName("buttonSpikeWall") as! MSButtonNode
        
        buttonFunnel = self.childNodeWithName("buttonFunnel") as! MSButtonNode
        
        goalBack = self.childNodeWithName("goalBack") as! SKSpriteNode
        
        spikeWallBack = self.childNodeWithName("spikeWallBack") as! SKSpriteNode
        
        funnelBack = self.childNodeWithName("funnelBack") as! SKSpriteNode
        
        
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        
        if self.selectWhatever.timesPressedGoals % 2 != 0 {
            self.goalBack.color = .greenColor()
            
        }
        if self.selectWhatever.timesPressedGoals % 2 == 0 {
            self.goalBack.color = .blueColor()
        }
        
        buttonGoal.selectedHandler = {
            self.selectWhatever.timesPressedGoals += 1
            if self.selectWhatever.timesPressedGoals % 2 != 0 {
                self.selectWhatever.obstacles[0] = 1
                self.goalBack.color = .greenColor()
                
            }
            if self.selectWhatever.timesPressedGoals % 2 == 0 {
                self.selectWhatever.obstacles[0] = 0
                self.goalBack.color = .blueColor()
            }
        }
        
        if self.selectWhatever.timesPressedSpikeWall % 2 != 0 {
            self.spikeWallBack.color = .greenColor()
        }
        if self.selectWhatever.timesPressedSpikeWall % 2 == 0 {
            self.spikeWallBack.color = .blueColor()
        }
        
        buttonSpikeWall.selectedHandler = {
            self.selectWhatever.timesPressedSpikeWall += 1
            if self.selectWhatever.timesPressedSpikeWall % 2 != 0 {
                self.selectWhatever.obstacles[1] = 2
                self.spikeWallBack.color = .greenColor()
            }
            if self.selectWhatever.timesPressedSpikeWall % 2 == 0 {
                self.selectWhatever.obstacles[1] = 0
                self.spikeWallBack.color = .blueColor()
            }
        }
        
        if self.selectWhatever.timesPressedFunnel % 2 != 0 {
            self.funnelBack.color = .greenColor()
            
        }
        if self.selectWhatever.timesPressedFunnel % 2 == 0 {
            self.funnelBack.color = .blueColor()
        }
        
        buttonFunnel.selectedHandler = {
            self.selectWhatever.timesPressedFunnel += 1
            if self.selectWhatever.timesPressedFunnel % 2 != 0 {
                self.selectWhatever.obstacles[2] = 3
                self.funnelBack.color = .greenColor()
                
            }
            if self.selectWhatever.timesPressedFunnel % 2 == 0 {
                self.selectWhatever.obstacles[2] = 0
                self.funnelBack.color = .blueColor()
            }
        }
    }
}
