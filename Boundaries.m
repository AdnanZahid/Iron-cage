//
//  Boundaries.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Boundaries.h"

@implementation Boundaries

CGFloat width;
CGFloat height;

- (id)initWithWidthAndHeight:(CGFloat)theWidth theHeight:(CGFloat)theHeight {
    
    if (self = [super init]) {
        
        width = theWidth;
        height = theHeight;
        
        [self addLeft];
//        [self addRight];
//        [self addRoof];
        [self addGround];
        
//        [self addFire];
    }
    
    return self;
}

- (void)addLeft {
    [self addXBoundary:-width/2];
}
- (void)addRight {
    [self addXBoundary:width];
}
- (void)addRoof {
    [self addYBoundary:height];
}
- (void)addGround {
    [self addYBoundary:-height/4];
}

- (void)addXBoundary:(CGFloat)X {
    
    SKNode *boundary = [SKNode node];
    boundary.position = CGPointMake(X, height/2);
    boundary.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, height * 1.5f)];
    
    boundary.physicsBody.allowsRotation = NO;
    boundary.physicsBody.affectedByGravity = NO;
    
    boundary.physicsBody.categoryBitMask = LEFTCATEGORY;
    
    boundary.physicsBody.contactTestBitMask = GROUNDCATEGORY | CHAINCATEGORY | OBSTACLECATEGORY | SHIELDCATEGORY | PAINKILLERCATEGORY | GEMCATEGORY;
    boundary.physicsBody.collisionBitMask = 0;
    
    [self addChild:boundary];
}

- (void)addYBoundary:(CGFloat)Y {
    
    SKNode *boundary = [SKNode node];
    boundary.position = CGPointMake(width/4, Y);
    boundary.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(width * 1.5f, 1)];
    
    boundary.physicsBody.allowsRotation = NO;
    boundary.physicsBody.affectedByGravity = NO;
    
    boundary.physicsBody.categoryBitMask = LEFTCATEGORY;
    
    boundary.physicsBody.contactTestBitMask = GROUNDCATEGORY | CHAINCATEGORY | OBSTACLECATEGORY | SHIELDCATEGORY | PAINKILLERCATEGORY | GEMCATEGORY;
    boundary.physicsBody.collisionBitMask = 0;
    
    [self addChild:boundary];
}

- (void)addFire {
    
    SKEmitterNode *emitter = [ParticleFactory particleWithName:@"fire"];
    
    emitter.particlePositionRange = CGVectorMake(width, 50);
    emitter.position = CGPointMake(width/2, 0);
    
    emitter.particleColor = [SKColor orangeColor];
    
    [self addChild:emitter];
}

@end