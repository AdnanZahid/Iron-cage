//
//  Blood.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteFactory.h"

@interface Blood : NSObject

@property SKSpriteNode *sprite;

- (id)init;

- (id)initWithNameAndDuration:(NSString *)atlasName duration:(float)duration;

@end