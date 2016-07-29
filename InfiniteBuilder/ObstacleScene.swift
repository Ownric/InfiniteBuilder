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
    
    var buttonSquareMaze: MSButtonNode!
    
    var buttonReverseFunnel: MSButtonNode!
    
    var buttonTrap: MSButtonNode!
    
    var selectWhatever: SelectScene!
    
    var goalsCheck: SKSpriteNode!
    
    var spikeWallCheck: SKSpriteNode!
    
    var funnelCheck: SKSpriteNode!
    
    var squareMazeCheck: SKSpriteNode!
    
    var reverseFunnelCheck: SKSpriteNode!
    
    var trapCheck: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonGoal = self.childNodeWithName("buttonGoal") as! MSButtonNode
        
        buttonSpikeWall = self.childNodeWithName("buttonSpikeWall") as! MSButtonNode
        
        buttonFunnel = self.childNodeWithName("buttonFunnel") as! MSButtonNode
        
        buttonSquareMaze = self.childNodeWithName("buttonSquareMaze") as! MSButtonNode
        
        buttonReverseFunnel = self.childNodeWithName("buttonReverseFunnel") as! MSButtonNode
        
        buttonTrap = self.childNodeWithName("buttonTrap") as! MSButtonNode
        
        goalsCheck = self.childNodeWithName("goalsCheck") as! SKSpriteNode
        
        spikeWallCheck = self.childNodeWithName("spikeWallCheck") as! SKSpriteNode
        
        funnelCheck = self.childNodeWithName("funnelCheck") as! SKSpriteNode
        
        squareMazeCheck = self.childNodeWithName("squareMazeCheck") as! SKSpriteNode
        
        reverseFunnelCheck = self.childNodeWithName("reverseFunnelCheck") as! SKSpriteNode
        
        trapCheck = self.childNodeWithName("trapCheck") as! SKSpriteNode
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        
        if self.selectWhatever.timesPressedGoals % 2 != 0 {
            self.goalsCheck.alpha = 1
            
        }
        if self.selectWhatever.timesPressedGoals % 2 == 0 {
            self.goalsCheck.alpha = 0
        }
        
        buttonGoal.selectedHandler = {
            self.selectWhatever.timesPressedGoals += 1
            if self.selectWhatever.timesPressedGoals % 2 != 0 {
                self.selectWhatever.obstacles[0] = 1
                self.goalsCheck.alpha = 1
                
            }
            if self.selectWhatever.timesPressedGoals % 2 == 0 {
                self.selectWhatever.obstacles[0] = 0
                self.goalsCheck.alpha = 0
            }
        }
        
        if self.selectWhatever.timesPressedSpikeWall % 2 != 0 {
            self.spikeWallCheck.alpha = 1
        }
        if self.selectWhatever.timesPressedSpikeWall % 2 == 0 {
            self.spikeWallCheck.alpha = 0
        }
        
        buttonSpikeWall.selectedHandler = {
            self.selectWhatever.timesPressedSpikeWall += 1
            if self.selectWhatever.timesPressedSpikeWall % 2 != 0 {
                self.selectWhatever.obstacles[1] = 2
                self.spikeWallCheck.alpha = 1
            }
            if self.selectWhatever.timesPressedSpikeWall % 2 == 0 {
                self.selectWhatever.obstacles[1] = 0
                self.spikeWallCheck.alpha = 0
            }
        }
        
        if self.selectWhatever.timesPressedFunnel % 2 != 0 {
            self.funnelCheck.alpha = 1
            
        }
        if self.selectWhatever.timesPressedFunnel % 2 == 0 {
            self.funnelCheck.alpha = 0
        }
        
        buttonFunnel.selectedHandler = {
            self.selectWhatever.timesPressedFunnel += 1
            if self.selectWhatever.timesPressedFunnel % 2 != 0 {
                self.selectWhatever.obstacles[2] = 3
                self.funnelCheck.alpha = 1
                
            }
            if self.selectWhatever.timesPressedFunnel % 2 == 0 {
                self.selectWhatever.obstacles[2] = 0
                self.funnelCheck.alpha = 0
            }
        }
        
        if self.selectWhatever.timesPressedSquareMaze % 2 != 0 {
            self.squareMazeCheck.alpha = 1
            
        }
        if self.selectWhatever.timesPressedSquareMaze % 2 == 0 {
            self.squareMazeCheck.alpha = 0
        }
        
        buttonSquareMaze.selectedHandler = {
            self.selectWhatever.timesPressedSquareMaze += 1
            if self.selectWhatever.timesPressedSquareMaze % 2 != 0 {
                self.selectWhatever.obstacles[3] = 4
                self.squareMazeCheck.alpha = 1
                
            }
            if self.selectWhatever.timesPressedSquareMaze % 2 == 0 {
                self.selectWhatever.obstacles[3] = 0
                self.squareMazeCheck.alpha = 0
            }
        }
        
        if self.selectWhatever.timesPressedReverseFunnel % 2 != 0 {
            self.reverseFunnelCheck.alpha = 1
            
        }
        if self.selectWhatever.timesPressedReverseFunnel % 2 == 0 {
            self.reverseFunnelCheck.alpha = 0
        }
        
        buttonReverseFunnel.selectedHandler = {
            self.selectWhatever.timesPressedReverseFunnel += 1
            if self.selectWhatever.timesPressedReverseFunnel % 2 != 0 {
                self.selectWhatever.obstacles[4] = 5
                self.reverseFunnelCheck.alpha = 1
                
            }
            if self.selectWhatever.timesPressedReverseFunnel % 2 == 0 {
                self.selectWhatever.obstacles[4] = 0
                self.reverseFunnelCheck.alpha = 0
            }
        }
        
        if self.selectWhatever.timesPressedTrap % 2 != 0 {
            self.trapCheck.alpha = 1
            
        }
        if self.selectWhatever.timesPressedTrap % 2 == 0 {
            self.trapCheck.alpha = 0
        }
        
        buttonTrap.selectedHandler = {
            self.selectWhatever.timesPressedTrap += 1
            if self.selectWhatever.timesPressedTrap % 2 != 0 {
                self.selectWhatever.obstacles[5] = 6
                self.trapCheck.alpha = 1
                
            }
            if self.selectWhatever.timesPressedTrap % 2 == 0 {
                self.selectWhatever.obstacles[5] = 0
                self.trapCheck.alpha = 0
            }
        }
    }
}
