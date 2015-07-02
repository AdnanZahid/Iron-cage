//
//  EnemyDelegate.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol EnemyDelegate <NSObject>

@required

-(void)respawnEnemy:(CGFloat)X Y:(CGFloat)Y;

@end