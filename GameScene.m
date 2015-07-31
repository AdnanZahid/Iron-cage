//
//  GameScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/12/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (void)addHero {
    
    hero = [Hero sharedInstance];
    hero.position = CGPointMake(width/8, height/4);
    
    hero.zPosition = 1;
    hero.physicsBody.dynamic = YES;
    
    [self addChild:hero];
}

- (void)addPainkiller:(NSUInteger)distance {
    
    CGFloat x = distance + width;
    CGFloat y = arc4random_uniform(height * 0.35f) + height/2;
    
    Painkiller *painkiller = [[Painkiller alloc] init];
    painkiller.sprite.position = CGPointMake(x, y);
    
    painkiller.sprite.zPosition = 2;
    
    [world addChild:painkiller.sprite];
    
    [self addHint:@"Collect the painkiller tablet" onOrOff:@"painkillerOff"];
}

- (void)addGem:(NSUInteger)distance {
    
    CGFloat x = distance + width;
    CGFloat y = arc4random_uniform(height * 0.15f) + height/4;
    
    for (int i = 0; i < 1 + arc4random_uniform(10); i++) {
        
        Gem *gem = [[Gem alloc] initWithBody];
        gem.sprite.position = CGPointMake(x + i * gem.sprite.size.width, y + arc4random_uniform(10) * gem.sprite.size.width);
        
        gem.sprite.zPosition = 3;
        
        [world addChild:gem.sprite];
    }
}

- (void)addPlatform:(NSUInteger)distance {
    
    Platform *platform = [[Platform alloc] initWithLength:6 + arc4random_uniform(4) difficulty:MIN(distance, difficulty)];
    
    platform.position = CGPointMake(distance + width, arc4random_uniform(height * 0.35f));
    
    platform.zPosition = 4;
    
    [world addChild:platform];
}

- (void)addChain:(NSUInteger)distance {
    
    CGFloat x = distance + width;
    CGFloat y = arc4random_uniform(height * 0.35f) + height/4;
    
    Chain *chain = [[Chain alloc] initWithPot:CGPointMake(x, y) secondAnchorPos:CGPointMake(x + 480, y) ropeWidth:20 potWidth:170 potId:0];
    
    chain.zPosition = 5;
    
    [world addChild:chain];
    [chain addJoints];
    
    [AudioFactory soundWithFilename:@"Chain" target:self];
}

- (void)addHook:(NSUInteger)distance {
    
    CGFloat x = distance + width;
    CGFloat y = arc4random_uniform(height * 0.15f) + height * 0.85f;
    
    Hook *hook = [[Hook alloc] initWithPot:CGPointMake(x, y) ropeWidth:40 potId:1];
    
    hook.zPosition = 6;
    
    [world addChild:hook];
    [hook addJoints];
    
    [self addHint:@"Shoot the red chain" onOrOff:@"hookOff"];
    
    [AudioFactory soundWithFilename:@"Hook" target:self];
}

- (void)addPlatformOrChain {
    
    if (arc4random_uniform(2) == 0) {
        [self addPlatform:distanceToSpawn];
    }
    else {
        [self addChain:distanceToSpawn];
    }
}

- (void)addParticle {
    
    SKEmitterNode *particle = [ParticleFactory particleWithDuration:1 target:self];
    
    particle.zPosition = 7;
    
    [[Shuriken sharedInstanceOnce] addChild:particle];
}

- (void)addBlood {
    
    Blood *blood = [[Blood alloc] init];
    
    blood.sprite.zPosition = 8;
    
    [hero addChild:blood.sprite];
    
    [AudioFactory soundWithFilename:@"Blood" target:self];
}

- (void)addPickupShield:(NSUInteger)distance {
    
    if (!isShielded) {
        
        CGFloat x = distance + width;
        CGFloat y = arc4random_uniform(height * 0.35f) + height/4;
        
        [Shield sharedInstanceWithXandYandWorld:x y:y world:world];
        
        [self addHint:@"Collect the shield" onOrOff:@"shieldOff"];
    }
}

- (void)addShield {
    
    shield = [[Shield alloc] init];
    [hero addChild:shield.sprite];
    
    isShielded = YES;
    
    [AudioFactory soundWithFilename:@"ShieldTaken" target:self];
}

- (void)addEnemy {
    
    enemyAlive = YES;
    
    float delayInSeconds = 5 + arc4random_uniform(difficulty);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        enemy = [[Enemy alloc] initWithPosition:width Y:hero.position.y];
        
        SKSpriteNode *enemySprite = [enemy sprite];
        enemy.delegate = self;
        
        enemy.sprite.zPosition = 10;
        
        [self addChild:enemySprite];
        
        [AudioFactory soundWithFilename:@"Enemy" target:self];
    });
}

- (void)addShuriken {
    
    if (canAddShuriken) {
        
        canAddShuriken = NO;
        
        SKSpriteNode *shuriken = [Shuriken sharedInstance];
        [shuriken setHidden:NO];
        
        shuriken.position = CGPointMake(hero.position.x + shuriken.size.width, hero.position.y + shuriken.size.height);
        [self addParticle];
        
        shuriken.zPosition = 11;
        
        [self addChild:shuriken];
        
        [AudioFactory soundWithFilename:@"Shuriken" target:self];
        
        SKAction *moveAwayFromPlayer = [SKAction moveTo:CGPointMake(width * 2, shuriken.position.y) duration:2];
        
        [shuriken runAction:moveAwayFromPlayer completion:^{
        
            canAddShuriken = YES;
            [shuriken removeFromParent];
        }];
    }
}

- (void)addGemIcon {
    
    Gem *gem = [[Gem alloc] init];
    
    gem.sprite.position = CGPointMake(gem.sprite.size.width, height - gem.sprite.size.height * 1.25f);
    
    gemCount = [[Text alloc] initWithStringAndXandY:@"X 0" X:gem.sprite.size.width * 1.8f Y:height - gem.sprite.size.height * 1.9f];
    
    gem.sprite.zPosition = 12;
    gemCount.text.zPosition = 13;
    
    [self addChild:gemCount.text];
    
    [self addChild:gem.sprite];
}

- (void)addShurikenIcon {
    
    shurikenIcon = [[Shuriken alloc]init];
    
    shurikenIcon.sprite.position = CGPointMake(width/2.75f, height - shurikenIcon.sprite.size.height);
    
    shurikenIcon.sprite.zPosition = 14;
    
    [self addChild:shurikenIcon.sprite];
}

- (void)addHealthBar {
    
    healthBar = [[HealthBar alloc] init];
    
    [healthBar setProgress:health];
    
    SKSpriteNode *healthBarFrame = [SKSpriteNode spriteNodeWithImageNamed:@"healthBarFrame"];
    healthBarFrame.position = CGPointMake(width - healthBarFrame.size.width * 0.6f, height - healthBarFrame.size.height * 0.9f);
    
    healthBar.position = CGPointMake(width - healthBarFrame.size.width * 0.6f, height - healthBarFrame.size.height * 0.9f);
    
    healthBarFrame.zPosition = -1;
    healthBar.sprite.zPosition = 16;
    
    [self addChild:healthBarFrame];
    [self addChild:healthBar];
}

- (void)addHighscoreIcon {
    
    [GameKitHelper reportScore:gems];
    
    SKSpriteNode *highscore = [SKSpriteNode spriteNodeWithImageNamed:@"highscore"];
    highscore.position = CGPointMake(width/2, height/4);
    highscore.zPosition = 20;
    
    [self addChild:highscore];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [AudioFactory soundWithFilename:@"Highscore" target:self];
    });
}

- (void)addHint:(NSString *)string onOrOff:(NSString *)onOrOff {
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:onOrOff]) {
        
        [self addChild:[[[CloudyText alloc] initWithStringAndSceneAndGameOver:string scene:self gameOver:&gameOver] text]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey: onOrOff];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [AudioFactory soundWithFilename:@"FadeOut" target:self];
    }
}

- (void)timeDelayForDamage {
    
    isShielded = YES;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.25f * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        isShielded = NO;
    });
}

- (void)addBloodDied {
    
    NSString *bloodName = [NSString stringWithFormat:@"blood%d", 1 + arc4random_uniform(4)];
    Blood *blood = [[Blood alloc] initWithNameAndDuration:bloodName duration:2];
    
    blood.sprite.xScale = 2;
    blood.sprite.yScale = 2;
    blood.sprite.zPosition = 8;
    
    [hero addChild:blood.sprite];
}

- (void)gameOver {
    
    NSString *diedSound = [NSString stringWithFormat:@"Died%d", 1 + arc4random_uniform(6)];
    [AudioFactory soundWithFilename:diedSound target:self];
    
    hero.physicsBody.dynamic = NO;
    
    [self addBloodDied];
    [self addBloodDied];
    [self addBloodDied];
    [self addBloodDied];
    
    gameOver = YES;
    
    [self addChild:[[[Button alloc] initWithName:@"Restart" offset:-2 X:width/2 Y:height/2] button]];
    [self addChild:[[[Button alloc] initWithName:@"Exit" offset:2 X:width/2 Y:height/2] button]];
    
    if ([HighscoreFactory orderHighscoresAndReturnIfHighest:gems]) {
        
        [self addHighscoreIcon];
    }
}

- (void)pause {
    
    resume = [[[Button alloc] initWithName:@"Resume" offset:-2 X:width/2 Y:height/2] button];
    restart = [[[Button alloc] initWithName:@"Restart" offset:0 X:width/2 Y:height/2] button];
    exit = [[[Button alloc] initWithName:@"Exit" offset:2 X:width/2 Y:height/2] button];
    
    [self addChild:resume];
    [self addChild:restart];
    [self addChild:exit];
    
    gameOver = YES;
}

- (void)killpain {
    
    [AudioFactory soundWithFilename:@"Painkiller" target:self];
    
    if (health <= 50) {
        health += 50;
    }
    else {
        health = 100;
    }
    
    [healthBar setProgress:health];
}

- (void)damage {
    
    if (!isShielded) {
        
        health -= 10;
        [healthBar setProgress:health];
        
        if (health == 0) {
            
            [self gameOver];
        }
        
        [self addBlood];
        
        NSString *hurtSound = [NSString stringWithFormat:@"Hurt%d", 1 + arc4random_uniform(12)];
        [AudioFactory soundWithFilename:hurtSound target:self];
        
        [self timeDelayForDamage];
    }
    else {
        
        [shield.sprite removeFromParent];
        
        [self timeDelayForDamage];
    }
}

- (void)increaseGems {
    
    gems ++;
    
    NSString *gemString = [NSString stringWithFormat:@"X %lu", (unsigned long)gems];
    gemCount.text.text = gemString;
}

- (void)addParallax {
    
    NSArray *imageNames = @[@"foreground", @"middleground", @"background"];
    
#if TARGET_OS_IPHONE
    PBParallaxScrolling *parallax = [[PBParallaxScrolling alloc] initWithBackgrounds:imageNames size:CGSizeMake(width, height - kGADAdSizeFullBanner.size.height) direction:kParallaxTypeLeft fastestSpeed:kPBParallaxBackgroundDefaultSpeed andSpeedDecrease:kPBParallaxBackgroundDefaultSpeedDifferential];
#else
    PBParallaxScrolling *parallax = [[PBParallaxScrolling alloc] initWithBackgrounds:imageNames size:CGSizeMake(width, height) direction:kParallaxTypeLeft fastestSpeed:kPBParallaxBackgroundDefaultSpeed andSpeedDecrease:kPBParallaxBackgroundDefaultSpeedDifferential];
#endif
    
    self.parallaxBackground = parallax;
    [self addChild:parallax];
}

- (void)respawnEnemy:(CGFloat)X Y:(CGFloat)Y {
    
    enemyAlive = YES;
    
    [self addEnemy];
}

@end