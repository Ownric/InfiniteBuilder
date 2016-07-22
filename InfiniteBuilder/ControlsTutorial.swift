//
//  ControlsTutorialScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/21/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit


class ControlsTutorial: SKScene {
    /* UI Connections */
    var buttonTransitionTwo: MSButtonNode!
    
    var buttonControlJetPack: MSButtonNode!
    
    var buttonControlFlappy: MSButtonNode!
    
    var gameWhatever: GameScene!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonTransitionTwo = self.childNodeWithName("buttonTransitionTwo") as! MSButtonNode
        
        buttonControlJetPack = self.childNodeWithName("buttonControlJetPack") as! MSButtonNode
        
        buttonControlFlappy = self.childNodeWithName("buttonControlFlappy") as! MSButtonNode
        
        /* Setup restart button selection handler */
        buttonTransitionTwo.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = ObstaclesTutorial(fileNamed:"ObstaclesTutorial") as ObstaclesTutorial!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
            
            print(self.gameWhatever.selectWhatever.controlType)
        }
        
        buttonControlJetPack.selectedHandler = {
            self.gameWhatever.selectWhatever.controlType = 0
        }
        buttonControlFlappy.selectedHandler = {
            self.gameWhatever.selectWhatever.controlType = 1
        }
    }
}