//
//  Gear.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteFactory.h"
#import "Constants.h"
#import "ParticleFactory.h"

@interface Gear : NSObject

@property SKSpriteNode *sprite;

- (id)initWithGearDistance:(CGFloat)gearDistance;

@end