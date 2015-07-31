//
//  HighscoresScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "HighscoresScene.h"

@implementation HighscoresScene

- (void)didMoveToView:(SKView *)view {
    
    CGFloat width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    CGFloat height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    CGFloat height = CGRectGetMaxY(self.frame);
#endif
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSString *scoreOrder = [NSString stringWithFormat:@"highscore%d",i];
        NSUInteger score = [[NSUserDefaults standardUserDefaults] integerForKey:scoreOrder];
        
        NSString *string = [NSString stringWithFormat:@"%d) %lu", i+1, (unsigned long)score];
        
        [self addChild:[[[Text alloc] initWithStringAndXandY:string X:width/16 Y:(100 * (5-i) + 75)] text]];
    }
    
    SKButton *gameCenter = [[[Button alloc] initWithName:@"GameCenter" offset:2 X:width/2 Y:height * 0.65f] button];
    gameCenter.title.text = @"Game Center";
    [self addChild:gameCenter];
    [self addChild:[[[Button alloc] initWithName:@"Back" offset:2 X:width/2 Y:height * 0.2f] button]];
}

- (void)GameCenterAction {
    
#if TARGET_OS_IPHONE
    [[GameKitHelper sharedGameKitHelper] showLeaderboardAndAchievements:YES viewController:self.scene.view.window.rootViewController];
#else
    [[GameKitHelper sharedGameKitHelper] showLeaderboard:self.scene.view.window];
#endif
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

- (void)BackAction {
    
    [SceneFactory sceneFromScene:[MenuScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Back" target:self];
}

@end