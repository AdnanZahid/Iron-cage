//
//  MyGameScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "MyGameScene.h"

@implementation MyGameScene

-(void)didMoveToView:(SKView *)view {
    
    [AudioFactory musicWithFilename:@"GameScene"];
    
    gameOver = YES;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        gameOver = NO;
        #if TARGET_OS_IPHONE
            [self addHint:@"Tap left to jump, right to fire" onOrOff:@"tapLeftRightOff"];
        #else
            [self addHint:@"Press space to jump, F to fire" onOrOff:@"tapLeftRightOff"];
        #endif
                
        [AudioFactory soundWithFilename:@"Walk" target:self];
    });
    
    difficulty = [[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"];
    
    if (difficulty == 0) {
        
        difficulty = MEDIUM;
    }
    
    distanceTravelled = 0;
    distanceToSpawn = 0;
    velocity = kPBParallaxBackgroundDefaultSpeed;
    
    canJump = YES;
    isShielded = NO;
    canAddShuriken = YES;
    
    health = 100;
    enemyAlive = NO;
    
    gems = 0;
    
    world = [SKNode node];
    [self addChild:world];
    
    [self addPlatform:0];
    
    width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
    
    jumpHeight = height * 1.35f;
#else
    height = CGRectGetMaxY(self.frame);
    
    jumpHeight = height * 1.35f;
#endif
    
    [self addParallax];
    
    [self addChild:[[Boundaries alloc] initWithWidthAndHeight:width theHeight:height]];
    
    [self addHero];
    
    [self addEnemy];
    
    [self addPlatformOrChain];
    
    [self addGemIcon];
    
    [self addShurikenIcon];
    
    [self addHealthBar];
    
    pauseButton = [[[Button alloc] initWithNameAndScale:@"Pause" offset:-1 X:width Y:0 scale:0.5f] button];
    [self addChild:pauseButton];
    
    self.physicsWorld.contactDelegate = self;
}

#if TARGET_OS_IPHONE

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!gameOver) {
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        
        if (canJump) {
            canJump = NO;
            if (touchLocation.x < self.frame.size.width / 2) {
                
                NSString *jumpSound = [NSString stringWithFormat:@"Jump%d", 1 + arc4random_uniform(8)];
                [AudioFactory soundWithFilename:jumpSound target:self];
                
                [hero.physicsBody applyImpulse:CGVectorMake(0, jumpHeight)];
            }
        }
        
        if (touchLocation.x > self.frame.size.width / 2) {
            
            [self addShuriken];
        }
    }
}

#else

- (void)keyDown:(NSEvent *)event {
    
    if (!gameOver) {
        if (canJump) {
            canJump = NO;
            if(event.keyCode == SPACE) {
                
                NSString *jumpSound = [NSString stringWithFormat:@"Jump%d", 1 + arc4random_uniform(8)];
                [AudioFactory soundWithFilename:jumpSound target:self];
                
                [hero.physicsBody applyImpulse:CGVectorMake(0, jumpHeight)];
            }
        }
        
        if(event.keyCode == F_KEY) {
            
            [self addShuriken];
        }
    }
}

#endif

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
        
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == HEROCATEGORY) {
        if (secondBody.categoryBitMask == GROUNDCATEGORY) {
            
            if (!canJump) {
                
                [AudioFactory soundWithFilename:@"Walk" target:self];
            }
            
            canJump = YES;
        }
        else if (secondBody.categoryBitMask == CHAINCATEGORY) {
            
            canJump = YES;
        }
        else if (secondBody.categoryBitMask == SHIELDCATEGORY) {
            
            [secondBody.node removeFromParent];
            
            [self addShield];
        }
        else if (secondBody.categoryBitMask == OBSTACLECATEGORY) {
            
            [secondBody.node removeFromParent];
            
            [self damage];
        }
        else if (secondBody.categoryBitMask == PAINKILLERCATEGORY) {
            
            [secondBody.node removeFromParent];
            
            [self killpain];
        }
        else if (secondBody.categoryBitMask == GEMCATEGORY) {
            
            [AudioFactory soundWithFilename:@"Gem" target:self];
            
            [secondBody.node removeFromParent];
            
            [self increaseGems];
        }
    }
    else if (firstBody.categoryBitMask == SHURIKENCATEGORY) {
        if (secondBody.categoryBitMask == OBSTACLECATEGORY) {
            
            [secondBody.node removeFromParent];
        }
    }
    else if (firstBody.categoryBitMask == LEFTCATEGORY) {
        
        if (secondBody.categoryBitMask == GROUNDCATEGORY ||
            secondBody.categoryBitMask == CHAINCATEGORY ||
            secondBody.categoryBitMask == OBSTACLECATEGORY ||
            secondBody.categoryBitMask == SHIELDCATEGORY ||
            secondBody.categoryBitMask == PAINKILLERCATEGORY ||
            secondBody.categoryBitMask == GEMCATEGORY) {
            
            firstBody.node.position = CGPointMake(width/2, height/2);
            [secondBody.node removeFromParent];
        }
    }
}

- (void)update:(NSTimeInterval)currentTime {
    
    if (!gameOver) {
        
        hero.paused = NO;
        enemy.sprite.paused = NO;
        
        [self.parallaxBackground update:currentTime];
        
        if (canAddShuriken) {
            
            [shurikenIcon.sprite setHidden:NO];
        }
        else {
            
            [shurikenIcon.sprite setHidden:YES];
        }
        
        if (hero.position.y > height - hero.size.height/2) {
            
            CGFloat heroVelocityY = hero.physicsBody.velocity.dy;
            hero.physicsBody.velocity = CGVectorMake(hero.physicsBody.velocity.dx, MIN(fabs(heroVelocityY * 0.8f), heroVelocityY));
        }
        if (hero.position.y < 0) {
            
            [self damage];
            
            hero.position = CGPointMake(hero.position.x, height + hero.size.height);
        }
        
        hero.position = CGPointMake(width/8, hero.position.y);
        
        world.position = CGPointMake(world.position.x - velocity, world.position.y);
        distanceTravelled += velocity;
        distanceToSpawn += velocity;
        
        if (enemyAlive) {
            
            SKSpriteNode *shuriken = [Shuriken sharedInstanceOnce];
            
            if ([enemy.sprite intersectsNode:hero]) {
                
                [self damage];
                
                [enemy.sprite setHidden:YES];
            }
            else if ([enemy.sprite intersectsNode:shuriken]) {
                
                enemyAlive = NO;
                
                [enemy.sprite setHidden:YES];
            }
        }
        
        if (distanceTravelled > width) {
            
            distanceTravelled = 0;
            
            [self addPlatformOrChain];
            
            [self addGem:distanceToSpawn];
            
            int randomNumber = arc4random_uniform(difficulty);
            
            if (randomNumber == 0) {
                [self addHook:distanceToSpawn];
            }
            else if (randomNumber == 5) {
                [self addPickupShield:distanceToSpawn];
            }
            else if (randomNumber == 10) {
                [self addPainkiller:distanceToSpawn];
            }
        }
    }
    else {
        hero.paused = YES;
        enemy.sprite.paused = YES;
    }
}

-(void)PauseAction {
    
    [pauseButton removeFromParent];
    
    [self pause];
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

-(void)ResumeAction {
    
    [self addChild:pauseButton];
    
    [resume removeFromParent];
    [restart removeFromParent];
    [exit removeFromParent];
    
    gameOver = NO;
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

-(void)RestartAction {
    
    [SceneFactory sceneFromScene:[MyGameScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

-(void)ExitAction {
    
    [[AudioFactory sharedInstance] stop];
    
    [SceneFactory sceneFromScene:[MainMenuScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Back" target:self];
}

@end