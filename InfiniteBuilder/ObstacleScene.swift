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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonGoal = self.childNodeWithName("buttonGoal") as! MSButtonNode
        
        buttonSpikeWall = self.childNodeWithName("buttonSpikeWall") as! MSButtonNode
        
        buttonFunnel = self.childNodeWithName("buttonFunnel") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            skView.presentScene(self.selectWhatever)
        }
        
        buttonGoal.selectedHandler = {
            self.selectWhatever.timesPressedGoals += 1
            if self.selectWhatever.timesPressedGoals % 2 != 0 {
                self.selectWhatever.obstacles[0] = 1
            }
            if self.selectWhatever.timesPressedGoals % 2 == 0 {
                self.selectWhatever.obstacles[0] = 0
            }
            
        }
        buttonSpikeWall.selectedHandler = {
            self.selectWhatever.timesPressedSpikeWall += 1
            if self.selectWhatever.timesPressedSpikeWall % 2 != 0 {
                self.selectWhatever.obstacles[1] = 2
            }
            if self.selectWhatever.timesPressedSpikeWall % 2 == 0 {
                self.selectWhatever.obstacles[1] = 0
            }
            print(self.selectWhatever.timesPressedSpikeWall)
        }
        buttonFunnel.selectedHandler = {
            self.selectWhatever.timesPressedFunnel += 1
            if self.selectWhatever.timesPressedFunnel % 2 != 0 {
                self.selectWhatever.obstacles[2] = 3
            }
            if self.selectWhatever.timesPressedFunnel % 2 == 0 {
                self.selectWhatever.obstacles[2] = 0
            }
        }
    }
}
