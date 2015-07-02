//
//  Gem.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Gem : NSObject

@property SKSpriteNode *sprite;

- (id)init;

- (id)initWithBody;

@end