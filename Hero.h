//
//  Hero.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/23/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "SpriteFactory.h"

@interface Hero : NSObject

+ (SKSpriteNode *)sharedInstance;

@end