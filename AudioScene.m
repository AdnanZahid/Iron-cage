//
//  AudioScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "AudioScene.h"

@implementation AudioScene {
    
    SKButton *sound;
    SKButton *music;
}

- (void)didMoveToView:(SKView *)view {
    
    CGFloat width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    CGFloat height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    CGFloat height = CGRectGetMaxY(self.frame);
#endif
    
    sound = [[[Checkbox alloc] initWithName:@"Sound" offset:0 X:width/16 Y:height * 0.65f] checkbox];
    music = [[[Checkbox alloc] initWithName:@"Music" offset:0 X:width/16 Y:height * 0.2f] checkbox];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"soundOff"]) {
        sound.title.text = @"☐Sound";
    }
    else {
        sound.title.text = @"☑ Sound";
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicOff"]) {
        
        music.title.text = @"☐ Music";
    }
    else {
        music.title.text = @"☑ Music";
    }
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    [self addChild:sound];
    [self addChild:music];
    [self addChild:[[[Button alloc] initWithName:@"Back" offset:2 X:width/2 Y:height * 0.2f] button]];
}

- (void)SoundAction {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"soundOff"]) {
        
        sound.title.text = @"☑ Sound";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"soundOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        sound.title.text = @"☐ Sound";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)MusicAction {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicOff"]) {
        
        [[AudioFactory sharedInstance] setVolume:1];
        
        music.title.text = @"☑ Music";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"musicOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (![[AudioFactory sharedInstance] isPlaying]) {
            [AudioFactory musicWithFilename:@"GameScene"];
        }
    }
    else {
        
        [[AudioFactory sharedInstance] setVolume:0];
        
        music.title.text = @"☐ Music";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"musicOff"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)BackAction {
    
    [SceneFactory sceneFromScene:[MenuScene class] target:self];
}

@end