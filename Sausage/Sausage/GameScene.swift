//
//  GameScene.swift
//  Sausage
//
//  Created by Nabylah on 13/04/2019.
//  Copyright © 2019 top. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let BirdCat:UInt32 = 1
    let SaucisseCat:UInt32 = 2
    let saucissesCat:UInt32 = 4
    let arrowCat:UInt32 = 8
    let sceneCat:UInt32=16
    
    
    private var dimBird:CGSize=CGSize(width: 70, height: 70)
    private var dimSaucisson:CGSize=CGSize(width: 60, height: 60)
    private var bird = SKSpriteNode()
    private var saucisson = SKSpriteNode()
    
    var foodSpeed: Int = 0
    
    private var EcranX:CGFloat = CGFloat()
    private var EcranY:CGFloat = CGFloat()
    
    private let jump:CGVector = CGVector(dx: 0, dy: 350)
    
    private var grav:CGVector = CGVector(dx: 0, dy: -10)
    
    struct birdscore{
        static var Tscore = [(String, Int)]()
        static var initialScore: Int = 0
    }
    
    private var scoreLab:SKLabelNode
    
    var score: Int = {
        didSet{
            scoreLab.text = " Score : \(score)"
        }
    }

    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint=CGPoint(x:0,y:0)
        
        EcranX = self.size.width
        EcranY = self.size.height
        physicsWorld.contactDelegate = self as! SKPhysicsContactDelegate
        
        
        physicsWorld.gravity = grav
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: frame.minX, width: frame.width*2, height: frame.height))
        self.physicsBody?.collisionBitMask = sceneCat
        
        
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.name="background"
        background.zPosition = -1
        background.anchorPoint = CGPoint(x:0, y:0)
        background.position=CGPoint(x:0,y:0)
        
        self.addChild(background)
        addBird()
        addSaucisse()
        
    
    
    
}
    
    
    func addBird(){
        bird = SKSpriteNode(imageNamed: "cutebird1")
        bird.name="bird"
        
        bird.zPosition=0
        bird.anchorPoint=CGPoint(x:0, y:0)
        bird.position=CGPoint(x:0, y:0)
        
        bird.physicsBody = SKPhysicsBody(rectangleOf: dimBird)
        bird.physicsBody?.collisionBitMask = BirdCat
        bird.physicsBody?.contactTestBitMask = SaucisseCat
        bird.physicsBody?.contactTestBitMask = saucissesCat
        bird.physicsBody?.contactTestBitMask = arrowCat
        bird.physicsBody?.allowsRotation=false
        self.addChild(bird)
        
        
        
        
    }
    
    
    func addSaucisse(){
        saucisson = SKSpriteNode(imageNamed: "saucisson")
        let saucissonX = CGFloat.random(in: EcranX...(EcranY*2))
        let saucissonY = CGFloat.random(in: EcranY...(EcranY*2))
        
        
        saucisson.name = "saucisson"
        saucisson.anchorPoint=CGPoint(x:0, y:0)
        saucisson.position=CGPoint(x : saucissonX, y: saucissonY)
        
        saucisson.size = dimSaucisson
        
        
        saucisson.physicsBody = SKPhysicsBody(rectangleOf: dimSaucisson)
        saucisson.physicsBody?.collisionBitMask = SaucisseCat
        saucisson.physicsBody?.affectedByGravity=false
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.node?.name=="bird" && contact.bodyB.node?.name=="saucisson"){
            
            birdscore.initialScore = score
            let storyboard = UIStoryboard(name: "main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController(withIdentifier: "endscore")
            
            
            
        }
    }
    

    

    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            
         bird.physicsBody?.applyImpulse(jump)
            
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        addSaucisse()
        
        <#code#>
    }
}
