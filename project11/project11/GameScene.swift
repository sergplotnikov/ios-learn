//
//  GameScene.swift
//  project11
//
//  Created by user165519 on 7/17/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!

var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!

var editingMode: Bool = false {
    didSet {
        if editingMode {
            editLabel.text = "Done"
        } else {
            editLabel.text = "Edit"
        }
    }
}
    var ballList = Array<String>()
    var ballNums = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        /*let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = CGPoint(x: 512, y: 0)
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
         */
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        print("path=\(path)")
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        print("items=\(items)")
        
        for item in items {
            if item.hasPrefix("ball"){
                //picture to load
                ballList.append(item)
                
            }
        }
        print(ballList)

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
           
            
            let objects = nodes(at: location)

            if objects.contains(editLabel) {
                editingMode.toggle()
            } else
            {
                    if editingMode {
                        // create a box
                        let size = CGSize(width: Int.random(in: 50...128), height: 8)
                        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                        box.zRotation = CGFloat.random(in: 0...3)
                        box.position = location

                        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                        box.physicsBody?.isDynamic = false
                        
                        /*
                        let spin = SKAction.rotate(byAngle: CGFloat.random(in: -2*CGFloat.pi ... CGFloat.pi), duration: TimeInterval(Float.random(in: 0.1 ... 0.5)))
                        let scale1 = SKAction.scale(to: 0.1, duration: 0.3)
                        let scale2 = SKAction.scale(to: 1, duration: 0.3)
                        let scale3 = SKAction.scale(to: 2, duration: 0.3)
                        let scale4 = SKAction.scale(to: 1, duration: 0.3)
                        let seq = SKAction.sequence([scale1,spin,scale2,spin,scale3,spin,scale4,spin])
                        //let gr = SKAction.group([spin,seq])
                        let spinForever = SKAction.repeatForever(seq)
                        box.run(spinForever)
                        */
                        box.name = "box"
                        addChild(box)
                    } else {
                        if ballNums < 5 {
                        /*let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
                         box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
                         box.physicsBody?.restitution = 0.0
                         box.position = location
                         addChild(box)*/
                        let r = Int.random(in: 0...ballList.count-1)
                        let ball = SKSpriteNode(imageNamed: ballList[r])
                        //let ball = SKSpriteNode(imageNamed: "ballRed")
                        ball.name = "ball"
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0 )
                        ball.physicsBody?.restitution = CGFloat.random(in: 0.5 ... 1)
                        ball.position = CGPoint(x: location.x, y:frame.size.height)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        addChild(ball)
                        ballNums += 1
                        }
                        
                    }
                
            }
        }
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
             slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
             slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
             slotBase.name = "bad"
        }

        slotBase.position = position
        slotGlow.position = position
        
        addChild(slotBase)
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 5)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        
    }
    
    func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { print("nodeA is ghost"); return }
        guard let nodeB = contact.bodyB.node else { print("nodeB is ghost"); return }
        
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
        else if object.name == "box" {
            print("hit box")
            let spin = SKAction.rotate(byAngle: CGFloat.random(in: -2*CGFloat.pi ... CGFloat.pi), duration: TimeInterval(Float.random(in: 0.1 ... 0.5)))
            let scale1 = SKAction.scale(to: 0, duration: 1)
            let scale2 = SKAction.scale(to: 1, duration: 1)
            let scale3 = SKAction.scale(to: 2, duration: 0.3)
            let scale4 = SKAction.scale(to: 1, duration: 0.3)
            let seq = SKAction.sequence([scale1,spin,scale2,spin,scale3,spin,scale4,spin])
            //let gr = SKAction.group([spin,seq])
            //let spinForever = SKAction.repeatForever(seq)
            object.run(seq)
        }
    }

func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    ballNums -= 1
    }
    
    
}
