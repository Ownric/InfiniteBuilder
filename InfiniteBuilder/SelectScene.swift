//
//  MainSelectScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright © 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

class SelectScene: SKScene {
    
    /* UI Connections */
    var buttonReturn: MSButtonNode!
    
    var buttonTruePlay: MSButtonNode!
    
    var buttonControls: MSButtonNode!
    
    var buttonObstacles: MSButtonNode!
    
    var buttonSpeed: MSButtonNode!
    
    var scrollSpeed: CGFloat = 240
    
    var highScore: Int = 0
    
    var controlType: Int = 1
    
    var obstacles: [Int] = [0, 0, 0]
    
    var timesPressedGoals: Int = 0
    
    var timesPressedSpikeWall: Int = 0
    
    var timesPressedFunnel: Int = 0
    
    var playBackground: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        buttonTruePlay = self.childNodeWithName("buttonTruePlay") as! MSButtonNode
        
        buttonControls = self.childNodeWithName("buttonControls") as! MSButtonNode
        
        buttonObstacles = self.childNodeWithName("buttonObstacles") as! MSButtonNode
        
        buttonSpeed = self.childNodeWithName("buttonSpeed") as! MSButtonNode
        
        playBackground = self.childNodeWithName("playBackground") as! SKSpriteNode
        
        if self.obstacles == [0,0,0] {
            self.playBackground.alpha = 0.5
        }
        if self.obstacles != [0,0,0] {
            self.playBackground.alpha = 1.0
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = MainScene(fileNamed:"MainScene") as MainScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup play button selection handler */
        buttonTruePlay.selectedHandler = {
            if self.obstacles != [0,0,0] {
                /* Grab reference to our SpriteKit view */
                let skView = self.view as SKView!
                
                /* Load Game scene */
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                
                scene.selectWhatever = self
                scene.scrollSpeed = self.scrollSpeed //here
                
                /* Ensure correct aspect mode */
                scene.scaleMode = .AspectFill
                
                /* Show debug */
                skView.showsPhysics = true
                skView.showsDrawCount = true
                skView.showsFPS = true
                
                /* Start game scene */
                skView.presentScene(scene)
            }
            
        }
        
        /* Setup play button selection handler */
        buttonControls.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = ControlsScene(fileNamed:"ControlsScene") as ControlsScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup restart button selection handler */
        buttonObstacles.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = ObstacleScene(fileNamed:"ObstacleScene") as ObstacleScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup restart button selection handler */
        buttonSpeed.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = SpeedScene(fileNamed:"SpeedScene") as SpeedScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug */
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    }
    
}