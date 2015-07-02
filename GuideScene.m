//
//  GuideScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "GuideScene.h"

@implementation GuideScene

- (void)didMoveToView:(SKView *)view {
    
    CGFloat width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    CGFloat height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    CGFloat height = CGRectGetMaxY(self.frame);
#endif
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    
    #if TARGET_OS_IPHONE
        [self addChild:[[[Text alloc] initWithStringAndXandY:@"1) Tap left to jump" X:width/16 Y:height*0.8f] text]];
        [self addChild:[[[Text alloc] initWithStringAndXandY:@"2) Tap right to fire" X:width/16 Y:height*0.6f] text]];
    #else
        [self addChild:[[[Text alloc] initWithStringAndXandY:@"1) Press space to jump" X:width/16 Y:height*0.8f] text]];
        [self addChild:[[[Text alloc] initWithStringAndXandY:@"2) Press F to fire" X:width/16 Y:height*0.6f] text]];
    #endif
    
    [self addChild:[[[Text alloc] initWithStringAndXandY:@"3) Collect gems" X:width/16 Y:height*0.4f] text]];
    [self addChild:[[[Text alloc] initWithStringAndXandY:@"4) Avoid obstacles" X:width/16 Y:height*0.2f] text]];
    
    [self addChild:[[[Button alloc] initWithName:@"Tutorial" offset:2 X:width/2 Y:height * 0.65f] button]];
    [self addChild:[[[Button alloc] initWithName:@"Back" offset:2 X:width/2 Y:height * 0.2f] button]];
}

- (void)TutorialAction {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"painkillerOff"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"hookOff"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"shieldOff"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"tapLeftRightOff"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SceneFactory sceneFromScene:[MyGameScene class] target:self];
}

- (void)BackAction {
    
    [SceneFactory sceneFromScene:[MainMenuScene class] target:self];
}

@end