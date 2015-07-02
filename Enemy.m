//
//  Enemy.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/23/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

- (id)initWithPosition:(CGFloat)X Y:(CGFloat)Y {
    
    if (self = [super init]) {
        
        _sprite = [SpriteFactory spriteWithAtlas:@"enemy"];
        
        [self addBlood];
        
        [self spawn:_sprite X:X Y:Y];
    }
    
    return self;
}

- (void)addBlood {
    
    Blood *blood = [[Blood alloc] initWithNameAndDuration:@"blood2" duration:1];
    
    blood.sprite.position = CGPointMake(blood.sprite.position.x - blood.sprite.size.width/12, blood.sprite.position.y + blood.sprite.size.width/8);
    
    [_sprite addChild:blood.sprite];
}

- (void)spawn:(SKSpriteNode *)enemy X:(CGFloat)X Y:(CGFloat)Y {
    
    SKSpriteNode *hero = [Hero sharedInstance];
    enemy.position = CGPointMake(X, Y);
    
    SKAction *moveTowardsPlayer = [SKAction moveTo:CGPointMake(-_sprite.size.width, hero.position.y) duration:1.6f];
    [enemy runAction:moveTowardsPlayer completion:^(void){
        
        [_delegate respawnEnemy:enemy.position.x Y:enemy.position.y];
        
        [enemy removeFromParent];
    }];
}

@end