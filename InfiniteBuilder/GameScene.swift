//
//  GameScene.swift
//  InfiniteBuilder
//
//  Created by Owen Meyer on 7/13/16.
//  Copyright (c) 2016 Owen Meyer. All rights reserved.
//

import SpriteKit

import UIKit

import Darwin

import Mixpanel

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    enum GameSceneState {
        case Active, GameOver
    }
    
    var scoreLabel: SKLabelNode!
    
    var highScoreLabel: SKLabelNode!
    
    /* Game management */
    var gameState: GameSceneState = .Active
    
    var obstacleLayer: SKNode!
    
    var hero: SKSpriteNode!
    
    var scrollLayer: SKNode!
    
    var sinceTouch : CFTimeInterval = 0
    
    var spawnTimer: CFTimeInterval = 0
    
    let fixedDelta: CFTimeInterval = 1.0/60.0 /* 60 FPS */
    
    weak var selectWhatever: SelectScene!
    
    var scrollSpeed: CGFloat = 0
    
    var touched: Bool = false
    
    var restartTouched = false
    
    var backTouched = false
    
    var touchNode: SKSpriteNode!
    
    var pointsTimer: CFTimeInterval = 0
    
    /* UI Connections */
    var buttonRestart: MSButtonNode!
    
    var buttonReturn: MSButtonNode!
    
    var points = 0
    
    var test: Int = 0
    
    var speedTimer: CFTimeInterval = 0
    
    var mixpanel: Mixpanel = Mixpanel.sharedInstance()
    
    var newAppDelagate: AppDelegate!
    
    var touchSFX: SKAudioNode?
    var playAction: SKAction!
    
    //let touchSFX = SKAction.playSoundFileNamed("maybeWork", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Recursive node search for 'hero' (child of referenced node) */
        hero = self.childNodeWithName("//hero") as! SKSpriteNode
        
        /* Set reference to scroll layer node */
        scrollLayer = self.childNodeWithName("scrollLayer")
        
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNodeWithName("obstacleLayer")
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        touchSFX = SKAudioNode(fileNamed: "maybeWork")
        self.addChild(touchSFX!)
        touchSFX?.autoplayLooped = false
        playAction = SKAction.play()
        
        /* Set UI connections */
        buttonRestart = self.childNodeWithName("buttonRestart") as! MSButtonNode
        
        buttonReturn = self.childNodeWithName("buttonReturn") as! MSButtonNode
        
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        
        highScoreLabel = self.childNodeWithName("highScoreLabel") as! SKLabelNode
        
        if self.selectWhatever.speedType == 240 {
            mixpanel.track("speed", properties: ["speed" : "slow"])
        }
        if self.selectWhatever.speedType == 300 {
            mixpanel.track("speed", properties: ["speed" : "medium"])
        }
        if self.selectWhatever.speedType == 360 {
            mixpanel.track("speed", properties: ["speed" : "fast"])
        }
        
        /* Setup restart button selection handler */
        buttonRestart.selectedHandler = {
            
            let skView = self.view as SKView!
            
            //let touchSFX = SKAction.playSoundFileNamed("thump", waitForCompletion: false)
            //self.runAction(touchSFX)
            
            //self.runAction(SKAction.playSoundFileNamed("click", waitForCompletion: false))
            
            self.restartTouched = true
            
            if self.restartTouched != false && self.backTouched != false {
                return
            }
            
            /* Load Game scene */
            let scene = SelectScene(fileNamed:"SelectScene") as SelectScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Show debug
            skView.showsPhysics = true
            skView.showsDrawCount = true
            skView.showsFPS = true*/
            
            self.selectWhatever.restart = true
            
            /* Start game scene */
            skView.presentScene(self.selectWhatever)
            
        }
        
        /* Setup restart button selection handler */
        buttonReturn.selectedHandler = {
            //print("puppies")
            //let touchSFX = SKAction.playSoundFileNamed("thump", waitForCompletion: false)
            //self.runAction(touchSFX)
            /* Grab reference to our SpriteKit view */
            
            self.selectWhatever.buttonsPressed[3] = 0
            
            let skView = self.view as SKView!
            
            self.backTouched = true
            
            if self.restartTouched != false && self.backTouched != false {
                return
            }
            
            //self.runAction(SKAction.playSoundFileNamed("click", waitForCompletion: false))
            
            /* Load Game scene */
            let scene = SelectScene(fileNamed:"SelectScene") as SelectScene!
            
            
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            self.selectWhatever.restart = false
            
            /* Restart game scene */
            skView.presentScene(self.selectWhatever)
            
        }
        
        /* Hide restart button */
        buttonRestart.state = .Hidden
        
        /* Hide return button */
        buttonReturn.state = .Hidden
        
        /* Reset Score label */
        scoreLabel.text = String(points)
        
        highScoreLabel.text = String(self.selectWhatever.highScore)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* Skip game update if game no longer active */
        if gameState != .Active { return }
        
        
        if self.selectWhatever.controlType == 1 {
            
            /* Reset velocity, helps improve response against cumulative falling velocity */
            hero.physicsBody?.velocity = CGVectorMake(0, 0)

            /* Apply vertical impulse */
            hero.physicsBody?.applyImpulse(CGVectorMake(0, 250))
        }
        
        if self.selectWhatever.controlType == 0 {
            touched = true
        }
        
        /* Apply subtle rotation */
        hero.physicsBody?.applyAngularImpulse(1)
        
        /* Reset touch timer */
        sinceTouch = 0
        
        
        /* Play SFX */
        touchSFX.runAction(playAction)
        self.removeFromParent()
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        /* Skip game update if game no longer active */
        if gameState != .Active {
            if buttonReturn.position.x != 160{
                buttonReturn.position.x -=  10
            }
            if buttonRestart.position.x != 160{
                buttonRestart.position.x -=  10
            }
            return
        }
        
        /* Grab current velocity */
        let velocityY = hero.physicsBody?.velocity.dy ?? 0
        
        if self.selectWhatever.controlType == 1 {
            if velocityY > 400 {
                hero.physicsBody?.velocity.dy = 400
            }
        }
        if self.selectWhatever.controlType == 0 {
            if velocityY > 300 {
                hero.physicsBody?.velocity.dy = 300
            }
        }
        
        /* Apply falling rotation */
        if sinceTouch > 0.1 {
            let impulse = -20000 * fixedDelta
            hero.physicsBody?.applyAngularImpulse(CGFloat(impulse))
        }
        
        if touched {
            /* Apply vertical impulse */
            hero.physicsBody?.applyImpulse(CGVectorMake(0, 2))
            
            
        }
        
        if gameState == .GameOver {
            if buttonRestart.position.x != 160{
                buttonRestart.position.x -= 0.5
            }
            
        }
        
        /* Clamp rotation */
        hero.zRotation.clamp(CGFloat(-20).degreesToRadians(),CGFloat(30).degreesToRadians())
        hero.physicsBody?.angularVelocity.clamp(-2, 2)
        
        if speedTimer % 10 == 0{
            
            self.selectWhatever.scrollSpeed += 0.02
            
        }
        
        if points > self.selectWhatever.highScore {
            self.selectWhatever.highScore = points
            
            mixpanel.track("highScore", properties: ["score" : points])
        }
        hero.position.x = CGFloat(0)
        
        /* Update last touch timer */
        sinceTouch+=fixedDelta
        
        /* Process world scrolling */
        scrollWorld()
        
        /* Process obstacles */
        updateObstacles()
        
        spawnTimer+=fixedDelta
        pointsTimer+=fixedDelta
        
    }
    
    func scrollWorld() {
        /* Scroll World */
        scrollLayer.position.x -= self.selectWhatever.scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through scroll layer nodes */
        for ground in scrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollLayer.convertPoint(ground.position, toNode: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.x <= -ground.size.width / 2 {
                
                
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPointMake( (self.size.width / 2) + ground.size.width, groundPosition.y)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convertPoint(newPosition, toNode: scrollLayer)
            }
        }
    }
    func updateObstacles() {
        /* Update Obstacles */
        obstacleLayer.position.x -= self.selectWhatever.scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convertPoint(obstacle.position, toNode: self)
            
            /* Check if obstacle has left the scene */
            if obstaclePosition.x <= -150 {
                
                /* Remove obstacle node from obstacle layer */
                obstacle.removeFromParent()
            }
            
        }
        
        /* Time to add a new obstacle? */
        
        if spawnTimer >= 1.5 {
            var choiceList: [Int] = []
            var choiceCount: Int = 0
            for x in self.selectWhatever.obstacles {
                if x != 0{
                    choiceList.append(x)
                    choiceCount += 1
                }
            }
            let obstacleType = choiceList[Int(arc4random_uniform(UInt32(choiceCount)))]
            
            if obstacleType == 1 {
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("Obstacle", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                
                /* Generate new obstacle position, start just outside screen and with a random y value */
                let randomPosition = CGPointMake(452, CGFloat.random(min: 234, max: 382))
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                
                // Reset spawn timer
                spawnTimer = 0
            }
            if obstacleType == 2 {
                
                let potentialFlip = Int(arc4random_uniform(UInt32(2)))
                
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("ObstacleTwo", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                if potentialFlip == 0 {
                    /* Generate new obstacle position, start just outside screen and with a random y value */
                    let randomPosition = CGPointMake(452, CGFloat.random(min: 288, max: 289))
                    
                    /* Convert new node position back to obstacle layer space */
                    newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                    newObstacle.yScale = newObstacle.yScale * 1
                }
                if potentialFlip == 1 {
                    /* Generate new obstacle position, start just outside screen and with a random y value */
                    let randomPosition = CGPointMake(452, CGFloat.random(min: 300, max: 301))
                    
                    /* Convert new node position back to obstacle layer space */
                    newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                    newObstacle.yScale = newObstacle.yScale * -1
                }
                spawnTimer = 0
            }
            if obstacleType == 3 {
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("ObstacleThree", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                
                /* Generate new obstacle position, start just outside screen and with a random y value */
                let randomPosition = CGPointMake(452, CGFloat.random(min: 254, max: 342))
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                
                // Reset spawn timer
                spawnTimer = 0
            }
            if obstacleType == 4 {
                let potentialFlip = Int(arc4random_uniform(UInt32(2)))
                
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("ObstacleFour", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                if potentialFlip == 0 {
                    /* Generate new obstacle position, start just outside screen and with a random y value */
                    let randomPosition = CGPointMake(452, CGFloat.random(min: 288, max: 289))
                    
                    /* Convert new node position back to obstacle layer space */
                    newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                    newObstacle.yScale = newObstacle.yScale * 1
                }
                if potentialFlip == 1 {
                    /* Generate new obstacle position, start just outside screen and with a random y value */
                    let randomPosition = CGPointMake(452, CGFloat.random(min: 300, max: 301))
                    
                    /* Convert new node position back to obstacle layer space */
                    newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                    newObstacle.yScale = newObstacle.yScale * -1
                }
                spawnTimer = 0
            }
            
            if obstacleType == 5 {
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("ObstacleFive", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                
                /* Generate new obstacle position, start just outside screen and with a random y value */
                let randomPosition = CGPointMake(452, CGFloat.random(min: 254, max: 342))
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                
                // Reset spawn timer
                spawnTimer = 0
            }
            
            if obstacleType == 6 {
                /* Create a new obstacle reference object using our obstacle resource */
                let resourcePath = NSBundle.mainBundle().pathForResource("ObstacleSix", ofType: "sks")
                let newObstacle = SKReferenceNode (URL: NSURL (fileURLWithPath: resourcePath!))
                obstacleLayer.addChild(newObstacle)
                
                /* Generate new obstacle position, start just outside screen and with a random y value */
                let randomPosition = CGPointMake(452, CGFloat.random(min: 194, max: 382))
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convertPoint(randomPosition, toNode: obstacleLayer)
                
                // Reset spawn timer
                spawnTimer = 0
            }
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "goal" || nodeB.name == "goal" {
            if gameState == .Active {
                /* Increment points */
                if pointsTimer > 1 {
                    points += 1
                }
                
                /* Update score label */
                scoreLabel.text = String(points)
                
                /* Resets points timer */
                pointsTimer = 0
                
                /* We can return now */
                return
            }
        }
        
        if nodeA.name == "roof" || nodeB.name == "roof" {
            if gameState == .Active {
                return
            }
        }
        
        if self.selectWhatever.controlType == 0 {
            if nodeA.name == "ground" || nodeB.name == "ground" {
                if gameState == .Active {
                    let touchSFX = SKAction.playSoundFileNamed("thump", waitForCompletion: false)
                    self.runAction(touchSFX)
                    return
                }
            }
        }
        if nodeA.name == "ground" || nodeB.name == "ground" {
            if gameState == .Active {
                let touchSFX = SKAction.playSoundFileNamed("thump", waitForCompletion: false)
                self.runAction(touchSFX)
            }
        }
        if nodeA.name == "goalPost" || nodeB.name == "goalPost" {
            mixpanel.track("killed by", properties: ["obstacle" : "goal"])
        }
        if nodeA.name == "spikeWall" || nodeB.name == "spikeWall" {
            mixpanel.track("killed by", properties: ["obstacle" : "spikeWall"])
        }
        if nodeA.name == "funnel" || nodeB.name == "funnel" {
            mixpanel.track("killed by", properties: ["obstacle" : "funnel"])
        }
        if nodeA.name == "squareMaze" || nodeB.name == "squareMaze" {
            mixpanel.track("killed by", properties: ["obstacle" : "squareMaze"])
        }
        if nodeA.name == "trap" || nodeB.name == "trap" {
            mixpanel.track("killed by", properties: ["obstacle" : "trap"])
        }
        
        /* Ensure only called while game running */
        if gameState != .Active { return }
        
        
        /* Hero touches anything, game over */
        
        /* Change game state to game over */
        gameState = .GameOver
        
        mixpanel.track("final score", properties: ["score" : points])
        
        self.selectWhatever.scrollSpeed = self.selectWhatever.speedType
        
        /* Stop any new angular velocity being applied */
        hero.physicsBody?.allowsRotation = false
        
        /* Reset angular velocity */
        hero.physicsBody?.angularVelocity = 0
        
        /* Stop hero flapping animation */
        hero.removeAllActions()
        
        /* Create our hero death action */
        let heroDeath = SKAction.runBlock({
            
            /* Put our hero face down in the dirt */
            self.hero.zRotation = CGFloat(-90).degreesToRadians()
            /* Stop hero from colliding with anything else */
            self.hero.physicsBody?.collisionBitMask = 0
        })
        
        /* Run action */
        hero.runAction(heroDeath)
        
        /* Show restart button */
        buttonRestart.state = .Active
        
        buttonReturn.state = .Active
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touched = false
        
    }
}
