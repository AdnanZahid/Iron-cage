//
//  Gem.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Gem.h"

@implementation Gem

- (id)init {
    
    if (self = [super init]) {
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"gem"];
    }
    
    return self;
}

- (id)initWithBody {
    
    if (self = [super init]) {
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"gem"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.allowsRotation = NO;
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
        _sprite.physicsBody.categoryBitMask = GEMCATEGORY;
    }
    
    return self;
}

@end