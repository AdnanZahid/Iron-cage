//
//  Drill.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Drill.h"

@implementation Drill

- (id)initWithDrillDistance:(CGFloat)drillDistance {
    
    if (self = [super init]) {
        
        _sprite = [SpriteFactory spriteWithAtlas:@"drill"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.categoryBitMask = OBSTACLECATEGORY;
        _sprite.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        _sprite.physicsBody.collisionBitMask = HEROCATEGORY;
        
        SKEmitterNode *emitter = [ParticleFactory particleWithName:@"drillSpark"];
        emitter.position = CGPointMake(0, -50);
        [_sprite addChild:emitter];
        
        SKAction *moveLeft = [SKAction moveByX:0 y:-_sprite.size.height * 0.825f duration:0.5f];
        SKAction *moveRight = [SKAction moveByX:0 y:_sprite.size.height * 0.825f duration:0.5f];
        
        SKAction *moveLeftRightForever = [SKAction repeatActionForever:[SKAction sequence:@[moveLeft, moveRight]]];
        [_sprite runAction:moveLeftRightForever];
    }
    
    return self;
}

@end