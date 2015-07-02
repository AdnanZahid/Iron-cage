//
//  Hook.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Hook : SKNode

- (id)initWithPot:(CGPoint)firstAnchorPos ropeWidth:(int)ropeWidth potId:(int)potId;

- (void)addJoints;

@end