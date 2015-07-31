//
//  Shuriken.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Shuriken.h"

@implementation Shuriken

static SKSpriteNode *_sprite = nil;

+ (SKSpriteNode *)sharedInstance {
    
    _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"shuriken"];
    
    _sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_sprite.size.width];
    _sprite.physicsBody.dynamic = NO;
    
    _sprite.physicsBody.categoryBitMask = SHURIKENCATEGORY;
    _sprite.physicsBody.contactTestBitMask = OBSTACLECATEGORY;
    _sprite.physicsBody.collisionBitMask = OBSTACLECATEGORY;
    
    SKAction *oneRevolution = [SKAction rotateByAngle: -M_PI*2 duration: 0.25f];
    SKAction *repeat = [SKAction repeatActionForever:oneRevolution];
    [_sprite runAction:repeat];
    
    return _sprite;
}

+ (SKSpriteNode *)sharedInstanceOnce {
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"shuriken"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_sprite.size.width];
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.categoryBitMask = SHURIKENCATEGORY;
        _sprite.physicsBody.contactTestBitMask = OBSTACLECATEGORY;
        _sprite.physicsBody.collisionBitMask = OBSTACLECATEGORY;
        
        SKAction *oneRevolution = [SKAction rotateByAngle: -M_PI*2 duration: 0.25f];
        SKAction *repeat = [SKAction repeatActionForever:oneRevolution];
        [_sprite runAction:repeat];
    });
    
    return _sprite;
}

- (id)init {
    
    if (self = [super init]) {
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"shuriken"];
        
        SKAction *oneRevolution = [SKAction rotateByAngle: -M_PI*2 duration: 5];
        SKAction *repeat = [SKAction repeatActionForever:oneRevolution];
        [_sprite runAction:repeat];
    }
    
    return self;
}

@end