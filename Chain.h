//
//  Chain.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/25/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Chain : SKNode

- (id)initWithPot:(CGPoint)firstAnchorPos secondAnchorPos:(CGPoint)secondAnchorPos ropeWidth:(int)ropeWidth potWidth:(float)potWidth potId:(int)potId;

- (void)addJoints;

@end