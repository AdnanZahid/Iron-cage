//
//  Enemy.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/23/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Hero.h"
#import "EnemyDelegate.h"
#import "SpriteFactory.h"
#import "Blood.h"

@interface Enemy : NSObject

@property SKSpriteNode *sprite;
@property id delegate;

- (id)initWithPosition:(CGFloat)X Y:(CGFloat)Y;

@end