//
//  MenuScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

- (void)didMoveToView:(SKView *)view {
    
    CGFloat width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    CGFloat height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    CGFloat height = CGRectGetMaxY(self.frame);
#endif
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    
    [self addChild:[[[Button alloc] initWithName:@"Audio" offset:-2 X:width/2 Y:height * 0.65f] button]];
    [self addChild:[[[Button alloc] initWithName:@"Difficulty" offset:-2 X:width/2 Y:height * 0.2f] button]];
    
    [self addChild:[[[Button alloc] initWithName:@"Highscores" offset:2 X:width/2 Y:height * 0.65f] button]];
    [self addChild:[[[Button alloc] initWithName:@"Back" offset:2 X:width/2 Y:height * 0.2f] button]];
}

- (void)AudioAction {
    
    [SceneFactory sceneFromScene:[AudioScene class] target:self];
}

- (void)DifficultyAction {
    
    [SceneFactory sceneFromScene:[DifficultyScene class] target:self];
}

- (void)HighscoresAction {
    
    [SceneFactory sceneFromScene:[HighscoresScene class] target:self];
}

- (void)BackAction {
    
    [SceneFactory sceneFromScene:[MainMenuScene class] target:self];
}

@end