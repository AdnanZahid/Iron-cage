//
//  ParallaxScrolling.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/12/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface PBParallaxScrolling : SKSpriteNode

- (id) initWithBackgrounds: (NSArray *) backgrounds size: (CGSize) size direction: (ParallaxType) direction fastestSpeed: (CGFloat) speed andSpeedDecrease: (CGFloat) differential;

- (void) update: (NSTimeInterval) currentTime;

- (void) reverseMovementDirection;

@end