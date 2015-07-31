//
//  Chain.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/25/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Chain.h"

@implementation Chain

NSMutableArray *jointArray;

- (id)initWithPot:(CGPoint)firstAnchorPos secondAnchorPos:(CGPoint)secondAnchorPos ropeWidth:(int)ropeWidth potWidth:(float)potWidth potId:(int)potId {
    
    if (self = [super init]) {
        
        jointArray = [NSMutableArray array];
        
        NSString *imageName = [NSString stringWithFormat:@"chainCenter%d", 1+arc4random_uniform(2)];
        
        SKSpriteNode* pot = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        pot.name = [NSString stringWithFormat:@"pot_%d", potId];
        
        pot.size = CGSizeMake(potWidth, potWidth/1.69);
        pot.position = CGPointMake(firstAnchorPos.x , firstAnchorPos.y);
        pot.physicsBody = [SKPhysicsBody
                           bodyWithRectangleOfSize:
                           pot.size];
        pot.physicsBody.mass = 0.1f;
        pot.physicsBody.collisionBitMask = 0;
        pot.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        pot.physicsBody.restitution = 0;
        pot.physicsBody.categoryBitMask = CHAINCATEGORY;
        
        [self addChild:pot];
        
        //make the first rope
        [self addRopeJointItems:firstAnchorPos countJointElements:ropeWidth potId:potId ropeNumber:1];
        
        //make the second rope
        [self addRopeJointItems:secondAnchorPos countJointElements:ropeWidth potId:potId ropeNumber:2];
        
        pot.position = CGPointMake(firstAnchorPos.x + ((secondAnchorPos.x - firstAnchorPos.x) / 2), secondAnchorPos.y);
    }
    
    return self;
}

- (void)addRopeJointItems:(CGPoint)leftStartPosition countJointElements:(int)countJointElements potId:(int)potId ropeNumber:(int)ropeNumber {
    
    float itemJointWidth;
    
    itemJointWidth = 8;
    
    //first Physics Anchor
    SKSpriteNode * firstAnchor = [SKSpriteNode spriteNodeWithImageNamed:@"transparent"];
    firstAnchor.position = CGPointMake(leftStartPosition.x, leftStartPosition.y);
    firstAnchor.size = CGSizeMake(1, 1);
    firstAnchor.physicsBody = [SKPhysicsBody
                               bodyWithRectangleOfSize:
                               firstAnchor.size];
    firstAnchor.physicsBody.dynamic = NO;
//    firstAnchor.physicsBody.mass = 99999999999;
    
    firstAnchor.physicsBody.collisionBitMask = HEROCATEGORY;
    firstAnchor.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
    firstAnchor.physicsBody.categoryBitMask = CHAINCATEGORY;
    
    [self addChild:firstAnchor];
    
    //second Physics Anchor
    SKSpriteNode* secondAnchor = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"pot_%d", potId]];
    
    //add RopeElements
    for (int i=0; i<countJointElements; i++) {
        
        SKSpriteNode * item = [SKSpriteNode spriteNodeWithImageNamed:@"chainPiece"];
        item.name = [NSString stringWithFormat:@"%d_%d_ropeitem_%d", potId, ropeNumber, i];
        if(ropeNumber == 1) {
            item.position = CGPointMake(leftStartPosition.x + (i*itemJointWidth) + itemJointWidth/2, leftStartPosition.y);
        } else {
            item.position = CGPointMake(leftStartPosition.x - (i*itemJointWidth) - itemJointWidth/2, leftStartPosition.y);
        }
        
        item.size = CGSizeMake((itemJointWidth + 5) * 2, 20);
        
        item.physicsBody = [SKPhysicsBody
                            bodyWithRectangleOfSize:
                            item.size];
        //item.physicsBody.categoryBitMask = kNilOptions;
        
        item.physicsBody.collisionBitMask = 0;
        item.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        item.physicsBody.categoryBitMask = CHAINCATEGORY;
        
        [self addChild:item];
        
        //Add Joint to the element before
        SKPhysicsBody* bodyA;
        if (i == 0) {
            bodyA = firstAnchor.physicsBody;
        } else {
            bodyA = [self childNodeWithName:[NSString stringWithFormat:@"%d_%d_ropeitem_%d", potId, ropeNumber, i-1]].physicsBody;
        }
        SKPhysicsJointPin* joint;
        joint = [SKPhysicsJointPin jointWithBodyA:bodyA
                                            bodyB:item.physicsBody
                                           anchor:CGPointMake((item.position.x - item.size.width/2) + 5, item.position.y)];
        [jointArray addObject:joint];
        
        if (i == countJointElements -1 && ropeNumber == 1) {
            [self childNodeWithName:[NSString stringWithFormat:@"pot_%d", potId]].position =
            CGPointMake(item.position.x+secondAnchor.size.width/2, item.position.y-secondAnchor.size.height/2);
        } else {
            [self childNodeWithName:[NSString stringWithFormat:@"pot_%d", potId]].position =
            CGPointMake(item.position.x-secondAnchor.size.width/2, item.position.y-secondAnchor.size.height/2);
        }
    }
    
    //Add the Last Joint
    SKPhysicsJointPin* jointLast;
    
    if (ropeNumber == 1) {
        jointLast = [SKPhysicsJointPin jointWithBodyA:
                     [self childNodeWithName:[NSString stringWithFormat:@"%d_%d_ropeitem_%d", potId, ropeNumber, countJointElements - 1]].physicsBody
                                                bodyB:secondAnchor.physicsBody
                                               anchor:CGPointMake((secondAnchor.position.x-secondAnchor.size.width/2), secondAnchor.position.y+secondAnchor.size.height/2)];
    } else {
        jointLast = [SKPhysicsJointPin jointWithBodyA:
                     [self childNodeWithName:[NSString stringWithFormat:@"%d_%d_ropeitem_%d", potId, ropeNumber,countJointElements - 1]].physicsBody
                                                bodyB:secondAnchor.physicsBody
                                               anchor:CGPointMake(secondAnchor.position.x+secondAnchor.size.width/2, secondAnchor.position.y+secondAnchor.size.height/2)];
    }
    
    [jointArray addObject:jointLast];
}

- (void)addJoints {
    
    for (SKPhysicsJointPin *joint in jointArray) {
        
        [self.scene.physicsWorld addJoint:joint];
    }
}

@end