//
//  MainMenuScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

CGFloat width;
CGFloat height;

- (void)didMoveToView:(SKView *)view {
    
    if (![[AudioFactory sharedInstance] isPlaying]) {
        [AudioFactory musicWithFilename:@"MainMenuScene"];
    }
    
    width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    height = CGRectGetMaxY(self.frame);
#endif
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    
    [self addChild:[[[Button alloc] initWithName:@"Play" offset:-2 X:width/2 Y:height/4] button]];
    [self addChild:[[[Button alloc] initWithName:@"Guide" offset:0 X:width/2 Y:height/4] button]];
    [self addChild:[[[Button alloc] initWithName:@"Menu" offset:2 X:width/2 Y:height/4] button]];
    
#if TARGET_OS_IPHONE
#else
    [self addChild:[[[Button alloc] initWithName:@"Quit" offset:0 X:width/2 Y:height/16] button]];
#endif
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAuthenticationViewController)
     name:PresentAuthenticationViewController
     object:nil];
    
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    
    [gameKitHelper authenticateLocalPlayer];
    
    [GameKitHelper reportScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore1"]];
}

- (void)showAuthenticationViewController {
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    
#if TARGET_OS_IPHONE
    [self.scene.view.window.rootViewController presentModalViewController:gameKitHelper.authenticationViewController animated:YES];
#else
    [self.scene.view.window.contentViewController presentViewControllerAsSheet:gameKitHelper.authenticationViewController];
#endif
}

- (void)PlayAction {
    
    [SceneFactory sceneFromScene:[MyGameScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

- (void)GuideAction {
    
    [SceneFactory sceneFromScene:[GuideScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}

- (void)MenuAction {
    
    [SceneFactory sceneFromScene:[MenuScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Click" target:self];
}


#if TARGET_OS_IPHONE
#else
- (void)QuitAction {
    
    [NSApp terminate:self];
}
#endif

@end