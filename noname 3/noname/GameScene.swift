//
//  GameScene.swift
//  noname
//
//  Created by widget on 14-6-4.
//  Copyright (c) 2014年 widget. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    let myLabel = SKLabelNode()
    let myLabel2 = SKLabelNode()
    let myLabel3 = SKLabelNode()
    var started=false
    var restart=false
    var time = SKLabelNode()
    var sprites=[SKSpriteNode]()
    var count=0
    var level=20
    var total=0
    
    override func didMoveToView(view: SKView) {
        myLabel.text = "打地鼠";
        myLabel.fontSize = 65;
        // 为什么 是CGPoint
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
        
        myLabel2.text = "By 水乎";
        myLabel2.fontSize = 32;
        myLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100);
        
        let background = SKSpriteNode(imageNamed:"background")
        background.xScale = 1
        background.yScale = 1
        // CGPoint 和 CGPointMake的区别
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        // zPosition 的作用
        background.zPosition = -1
        
        self.addChild(myLabel)
        self.addChild(myLabel2)
        self.addChild(background)
        
        // 这个写法比较好
        var spawn = SKAction.runBlock({() in self.insert()})
        var delay = SKAction.waitForDuration(NSTimeInterval(0.1))
        var spawnThenDelay = SKAction.sequence([spawn, delay])
        var spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        self.runAction(spawnThenDelayForever)
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        
        if restart{
            myLabel3.removeFromParent()
            for item in sprites{
                item.removeFromParent()
            }
            sprites=[]
            restart=false
            started=true
        }
        else if started==false {
            started = true
            myLabel.removeFromParent()
            myLabel2.removeFromParent()

        }
        else{
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                var i = 0
                while i < sprites.count{
                    let item=sprites[i]
                    var value = hypotf(Float(location.x-item.position.x), Float(location.y-item.position.y))
                    if( value < Float(50)){
                        item.removeFromParent()
                        sprites.removeAtIndex(i)
                        break
                    }
                    i += 1
                }
                total++
                if total%10==0&&level>1{
                    switch level{
                    case 20:level=14
                    case 15:level=10
                    case 10:level=8
                    default:level--
                    }
                }
            }
        }
    }
    
    func insert(){
        if started==false{
            
        }
        else if(sprites.count>9){
            over()
        }
        else{
            if count<level{
                count++
            }
            else{
                count=0
                // arc4random() 是什么
                let x=CGFloat(arc4random() % 320)
                let y=CGFloat(arc4random() % 578)
                let location = CGPointMake(CGRectGetMidX(self.frame) + x - 160,CGRectGetMidY(self.frame) + y - 289)
                let sprite = SKSpriteNode(imageNamed:"target")
                
                sprite.xScale = 0.1
                sprite.yScale = 0.1
                sprite.position = location
                
                let action = SKAction.scaleBy(3, duration:0.2)
                
                sprite.runAction(action)
                
                self.addChild(sprite)
                sprites.append(sprite)
            }
        }
    }
    
    func over(){
        myLabel3.text = "游戏结束";
        myLabel3.fontSize = 65;
        myLabel3.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel3)
        restart=true
        started=false
        count=0
        level=20
        total=0
    }
    
}
