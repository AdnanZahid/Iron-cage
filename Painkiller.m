//
//  Painkiller.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Painkiller.h"

@implementation Painkiller

- (id)init {
    
    if (self = [super init]) {
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"painkiller"];
        
        _sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_sprite.size];
        _sprite.physicsBody.dynamic = NO;
        
        _sprite.physicsBody.categoryBitMask = PAINKILLERCATEGORY;
        _sprite.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
    }
    
    return self;
}

@end