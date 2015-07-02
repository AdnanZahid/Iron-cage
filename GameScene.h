//
//  MyGameScene.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/26/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Hero.h"
#import "Enemy.h"
#import "Boundaries.h"
#import "Platform.h"
#import "Chain.h"
#import "Hook.h"
#import "Shield.h"
#import "HealthBar.h"
#import "Shuriken.h"
#import "Painkiller.h"
#import "Gem.h"
#import "ParallaxScrolling.h"
#import "Button.h"
#import "SceneFactory.h"
#import "HighscoreFactory.h"
#import "Text.h"
#if TARGET_OS_IPHONE
#import <GoogleMobileAds/GoogleMobileAds.h>
#endif
#import "GameKitHelper.h"
#import "CloudyText.h"

@interface GameScene : SKScene <EnemyDelegate, SKPhysicsContactDelegate> {
    
    int difficulty;
    
    SKNode *universe;
    SKNode *world;
    
    CGFloat width;
    CGFloat height;
    
    CGFloat scaleX;
    CGFloat scaleY;
    
    CGFloat jumpHeight;
    
    SKSpriteNode *hero;
    Enemy *enemy;
    
    NSUInteger distanceTravelled;
    NSUInteger distanceToSpawn;
    NSUInteger velocity;
    
    BOOL canJump;
    BOOL isShielded;
    BOOL canAddShuriken;
    
    Shield *shield;
    NSUInteger health;
    BOOL gameOver;
    BOOL enemyAlive;
    
    HealthBar *healthBar;
    
    NSUInteger gems;
    Text *gemCount;
    
    Shuriken *shurikenIcon;
    
    SKButton *resume;
    SKButton *restart;
    SKButton *exit;
}

@property (nonatomic, strong) PBParallaxScrolling *parallaxBackground;

- (void)addHero;
- (void)addEnemy;
- (void)addPlatform:(NSUInteger)distance;
- (void)addChain:(NSUInteger)distance;
- (void)addHook:(NSUInteger)distance;
- (void)addPlatformOrChain;
- (void)addparticle;
- (void)addBlood;
- (void)addPickupShield:(NSUInteger)distance;
- (void)addShield;
- (void)addShuriken;
- (void)addPainkiller:(NSUInteger)distance;
- (void)addGem:(NSUInteger)distance;
- (void)addGemIcon;
- (void)addShurikenIcon;
- (void)addHealthBar;
- (void)addHint:(NSString *)string onOrOff:(NSString *)onOrOff;
- (void)pause;
- (void)killpain;
- (void)damage;
- (void)increaseGems;
- (void)addBlur;
- (void)addParallax;
- (void)respawnEnemy:(CGFloat)X Y:(CGFloat)Y;

@end