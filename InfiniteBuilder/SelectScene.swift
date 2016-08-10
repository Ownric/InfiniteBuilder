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
    var buttonHelp: MSButtonNode!
    
    var buttonTruePlay: MSButtonNode!
    
    var buttonControls: MSButtonNode!
    
    var buttonObstacles: MSButtonNode!
    
    var buttonSpeed: MSButtonNode!
    
    var scrollSpeed: CGFloat = 240
    
    var speedType: CGFloat = 240
    
    var controlType: Int = 0
    
    var obstacles: [Int] = [1, 2, 3, 4, 5, 6]
    
    var timesPressedGoals: Int = 1
    
    var timesPressedSpikeWall: Int = 1
    
    var timesPressedFunnel: Int = 1
    
    var timesPressedSquareMaze: Int = 1
    
    var timesPressedReverseFunnel: Int = 1
    
    var timesPressedTrap: Int = 1
    
    var restart: Bool = false
    
    var playBackground: SKSpriteNode!
    
    var buttonsPressed: [Int] = [0, 0, 0, 0, 0]
    
    //var newAppDelagate: AppDelegate!
    
    //var highScore = 0
    
    var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("myHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey:"myHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var beenToHelp = false
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        buttonHelp = self.childNodeWithName("buttonHelp") as! MSButtonNode
        
        buttonTruePlay = self.childNodeWithName("buttonTruePlay") as! MSButtonNode
        
        buttonControls = self.childNodeWithName("buttonControls") as! MSButtonNode
        
        buttonObstacles = self.childNodeWithName("buttonObstacles") as! MSButtonNode
        
        buttonSpeed = self.childNodeWithName("buttonSpeed") as! MSButtonNode
        
        playBackground = self.childNodeWithName("playBackground") as! SKSpriteNode
        
        if self.obstacles == [0,0,0,0,0,0] {
            self.playBackground.alpha = 0.5
        }
        if self.obstacles != [0,0,0,0,0,0] {
            self.playBackground.alpha = 1.0
        }
        
        //highScore = newAppDelagate.savedScore
        
        if restart == true {
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            self.runAction(SKAction.playSoundFileNamed("click", waitForCompletion: false))
            
            /* Load Game scene */
            let gameScene = GameScene(fileNamed:"GameScene") as GameScene!
            
            gameScene.selectWhatever = self
            gameScene.scrollSpeed = self.scrollSpeed
            
            /* Ensure correct aspect mode */
            gameScene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true */
            
            /* Start game scene */
            skView.presentScene(gameScene)
        }
        
        
        if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
            buttonsPressed = [0,0,0,0,0]
            return
        }
        
        
        
        /* Setup restart button selection handler */
        buttonHelp.selectedHandler = {
            
            /* Play sound when button is pressed */
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            self.buttonsPressed[4] = 1
            
            if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
                self.buttonsPressed = [0,0,0,0,0]
                return
            }
            
            /* Load Game scene */
            let scene = HelpScene(fileNamed:"HelpScene") as HelpScene!
            
            /* Makes this scene become the copy made in HelpScene */
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            /* Start game scene */
            skView.presentScene(scene)
            
        }
        
        /* Setup play button selection handler */
        buttonTruePlay.selectedHandler = {
            if self.obstacles != [0,0,0,0,0,0] {
                /* Grab reference to our SpriteKit view */
                let skView = self.view as SKView!
                
                self.buttonsPressed[3] = 1
                
                if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
                    self.buttonsPressed = [0,0,0,0,0]
                    return
                }
                
                let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
                self.runAction(touchSFX)
                
                /* Load Game scene */
                let gameScene = GameScene(fileNamed:"GameScene") as GameScene!
                
                gameScene.selectWhatever = self
                gameScene.scrollSpeed = self.scrollSpeed
                
                /* Ensure correct aspect mode */
                gameScene.scaleMode = .AspectFill
                
                /* Show debug*/
                skView.showsPhysics = true
                skView.showsDrawCount = true
                skView.showsFPS = true
                
                /* Start game scene */
                skView.presentScene(gameScene)
            }
        }
        
        /* Setup play button selection handler */
        buttonControls.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            self.buttonsPressed[0] = 1
            
            if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
                self.buttonsPressed = [0,0,0,0,0]
                return
            }
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            
            /* Load Game scene */
            let scene = ControlsScene(fileNamed:"ControlsScene") as ControlsScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup restart button selection handler */
        buttonObstacles.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            self.buttonsPressed[1] = 1
            
            if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
                self.buttonsPressed = [0,0,0,0,0]
                return
            }
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            
            /* Load Game scene */
            let scene = ObstacleScene(fileNamed:"ObstacleScene") as ObstacleScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            /* Start game scene */
            skView.presentScene(scene)
        }
        
        /* Setup restart button selection handler */
        buttonSpeed.selectedHandler = {
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            self.buttonsPressed[2] = 1
            
            if self.buttonsPressed != [1,0,0,0,0] && self.buttonsPressed != [0,1,0,0,0] && self.buttonsPressed != [0,0,1,0,0] && self.buttonsPressed != [0,0,0,1,0] && self.buttonsPressed != [0,0,0,0,1] && self.buttonsPressed != [0,0,0,0,0] {
                self.buttonsPressed = [0,0,0,0,0]
                return
            }
            
            let touchSFX = SKAction.playSoundFileNamed("click", waitForCompletion: false)
            self.runAction(touchSFX)
            
            /* Load Game scene */
            let scene = SpeedScene(fileNamed:"SpeedScene") as SpeedScene!
            
            scene.selectWhatever = self
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            /* Start game scene */
            skView.presentScene(scene)
        }
    }
}