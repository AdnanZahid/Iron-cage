//
//  Hook.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Hook.h"

@implementation Hook

NSMutableArray *jointArray;

- (id)initWithPot:(CGPoint)firstAnchorPos ropeWidth:(int)ropeWidth potId:(int)potId {
    
    if (self = [super init]) {
        
        jointArray = [NSMutableArray array];
        
        [self addRopeJointItems:firstAnchorPos countJointElements:ropeWidth potId:potId];
        
    }
    
    return self;
}

- (void)addRopeJointItems:(CGPoint)leftStartPosition countJointElements:(int)countJointElements potId:(int)potId {
    
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
    firstAnchor.physicsBody.categoryBitMask = OBSTACLECATEGORY;
    
    [self addChild:firstAnchor];
    
    //second Physics Anchor
    SKSpriteNode* secondAnchor = (SKSpriteNode*)[self childNodeWithName:[NSString stringWithFormat:@"pot_%d", potId]];
    
    //add RopeElements
    for (int i=0; i<countJointElements; i++) {
        
        SKSpriteNode *item;
        if (i != countJointElements - 1) {
            item = [SKSpriteNode spriteNodeWithImageNamed:@"hookPiece"];
            
            item.size = CGSizeMake((itemJointWidth + 5) * 2, 20);
        }
        else {
            item = [SKSpriteNode spriteNodeWithImageNamed:@"hook"];
        }
        
        item.name = [NSString stringWithFormat:@"%d_ropeitem_%d", potId, i];
        item.position = CGPointMake(leftStartPosition.x + (i*itemJointWidth) + itemJointWidth/2, leftStartPosition.y);
        
        item.physicsBody = [SKPhysicsBody
                            bodyWithRectangleOfSize:
                            item.size];
        //item.physicsBody.categoryBitMask = kNilOptions;
        
        item.physicsBody.collisionBitMask = HEROCATEGORY;
        item.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        item.physicsBody.categoryBitMask = OBSTACLECATEGORY;
        
        [self addChild:item];
        
        //Add Joint to the element before
        SKPhysicsBody* bodyA;
        if (i == 0) {
            bodyA = firstAnchor.physicsBody;
        } else {
            bodyA = [self childNodeWithName:[NSString stringWithFormat:@"%d_ropeitem_%d", potId, i-1]].physicsBody;
        }
        SKPhysicsJointPin* joint;
        joint = [SKPhysicsJointPin jointWithBodyA:bodyA
                                            bodyB:item.physicsBody
                                           anchor:CGPointMake((item.position.x - item.size.width/2) + 5, item.position.y)];
        [jointArray addObject:joint];
        
        [self childNodeWithName:[NSString stringWithFormat:@"pot_%d", potId]].position = CGPointMake(item.position.x+secondAnchor.size.width/2, item.position.y-secondAnchor.size.height/2);
    }
}

- (void)addJoints {
    
    for (SKPhysicsJointPin *joint in jointArray) {
        
        [self.scene.physicsWorld addJoint:joint];
    }
}

@end