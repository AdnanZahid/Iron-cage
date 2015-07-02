//
//  Shield.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Shield.h"

@implementation Shield

- (id)init {
    
    if (self = [super init]) {
        
        _sprite = [SpriteFactory spriteWithAtlas:@"shield"];
        
        _sprite.zPosition = 20;
    }
    
    return self;
}

+ (void)sharedInstanceWithXandYandWorld:(CGFloat)x y:(CGFloat)y world:(SKNode *)world {
    
    static SKSpriteNode *_sprite = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        _sprite = [SpriteFactory spriteWithAtlas:@"shield"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.categoryBitMask = SHIELDCATEGORY;
        _sprite.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        
        _sprite.position = CGPointMake(x, y);
        
        _sprite.zPosition = 9;
        
        [world addChild:_sprite];
    });
}

@end