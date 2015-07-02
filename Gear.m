//
//  Gear.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Gear.h"

@implementation Gear

- (id)initWithGearDistance:(CGFloat)gearDistance {
    
    if (self = [super init]) {
        
        _sprite = [SpriteFactory spriteWithAtlas:@"gear"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.categoryBitMask = OBSTACLECATEGORY;
        _sprite.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        _sprite.physicsBody.collisionBitMask = HEROCATEGORY;
        
        SKEmitterNode *emitter = [ParticleFactory particleWithName:@"gearSpark"];
        emitter.position = CGPointMake(0, -15);
        
        SKAction *reverseDirection = [SKAction runBlock:^{
            emitter.xScale *= -1;
        }];
        
        emitter.zPosition = 1;
        
        [_sprite addChild:emitter];
        
        SKAction *moveLeft = [SKAction moveByX:-gearDistance y:0 duration:2];
        SKAction *moveRight = [SKAction moveByX:gearDistance y:0 duration:2];
        
        SKAction *moveLeftRightForever = [SKAction repeatActionForever:[SKAction sequence:@[moveLeft, reverseDirection, moveRight, reverseDirection]]];
        [_sprite runAction:moveLeftRightForever];
    }
    
    return self;
}

@end