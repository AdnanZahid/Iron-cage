//
//  Platform.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Platform.h"

@implementation Platform

- (id)initWithLength:(int)length difficulty:(int)difficulty {
    
    if (self = [super init]) {
        
        NSString *tileName = [NSString stringWithFormat:@"tile%d", 1 + arc4random_uniform(4)];
        
        for (int i = 1; i <= length; i++) {
            
            SKSpriteNode *tile = [SKSpriteNode spriteNodeWithImageNamed:tileName];
            tile.position = CGPointMake(i * tile.size.width, tile.size.height/2);
            
            tile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tile.size];
            tile.physicsBody.dynamic = NO;
            
            tile.physicsBody.categoryBitMask = GROUNDCATEGORY;
            tile.physicsBody.contactTestBitMask = HEROCATEGORY | LEFTCATEGORY;
            tile.physicsBody.collisionBitMask = HEROCATEGORY;
            
            if (i == length && difficulty!= 0) {
                
                int random = arc4random_uniform(difficulty);
                if (random == 0) {
                    CGFloat gearDistance = (length - 3) * tile.size.width;
                    Gear *gear = [[Gear alloc] initWithGearDistance:gearDistance];
                    gear.sprite.position = CGPointMake(i * tile.size.width, tile.size.height * 1.25f);
                    gear.sprite.zPosition = 3;
                    
                    [self addChild:gear.sprite];
                    
                    
                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"soundOff"]) {
                        
                        [gear.sprite runAction:[SKAction playSoundFileNamed:@"Gear.wav" waitForCompletion:NO]];
                    }
                }
                else if (random == 1) {
                    CGFloat drillDistance = (length - 1) * tile.size.width;
                    Drill *drill = [[Drill alloc] initWithDrillDistance:drillDistance];
                    drill.sprite.position = CGPointMake((3 + arc4random_uniform(length - 4)) * tile.size.width, tile.size.height * 1.425f);
                    drill.sprite.zPosition = 1;
                    
                    [self addChild:drill.sprite];
                    
                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"soundOff"]) {
                        
                        [drill.sprite runAction:[SKAction playSoundFileNamed:@"Drill.wav" waitForCompletion:NO]];
                    }
                }
            }
            
            tile.zPosition = 2;
            [self addChild:tile];
        }
        
    }
    
    return self;
}

@end