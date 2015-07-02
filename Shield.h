//
//  Shield.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteFactory.h"
#import "Constants.h"

@interface Shield : NSObject

@property SKSpriteNode *sprite;

- (id)init;

+ (void)sharedInstanceWithXandYandWorld:(CGFloat)x y:(CGFloat)y world:(SKNode *)world;

@end