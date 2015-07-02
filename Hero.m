//
//  Hero.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/23/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Hero.h"

@implementation Hero

+ (SKSpriteNode *)sharedInstance {
    
    static SKSpriteNode *_sprite = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        _sprite = [SpriteFactory spriteWithAtlas:@"hero"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.mass = 1;
        _sprite.physicsBody.allowsRotation = NO;
        
        _sprite.physicsBody.categoryBitMask = HEROCATEGORY;
        _sprite.physicsBody.contactTestBitMask = GROUNDCATEGORY | OBSTACLECATEGORY | SHIELDCATEGORY | PAINKILLERCATEGORY | GEMCATEGORY;
        _sprite.physicsBody.collisionBitMask = GROUNDCATEGORY | OBSTACLECATEGORY;
    });
    
    return _sprite;
}

@end