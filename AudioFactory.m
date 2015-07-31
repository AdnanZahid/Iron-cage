//
//  AudioFactory.m
//  Iron cage
//
//  Created by Adnan Zahid on 7/1/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "AudioFactory.h"

@implementation AudioFactory

static AVAudioPlayer *_backgroundMusicPlayer = nil;

+ (void)soundWithFilename:(NSString *)filename target:(SKNode *)target {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"soundOff"]) {
    
        [target runAction:[SKAction playSoundFileNamed:[NSString stringWithFormat:@"%@.wav", filename] waitForCompletion:NO]];
    }
}

+ (AVAudioPlayer *)sharedInstance {
    
    return _backgroundMusicPlayer;
}

+ (void)musicWithFilename:(NSString *)filename {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"musicOff"]) {
        
        NSError *error;
        NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:@"aac"];
        _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        _backgroundMusicPlayer.numberOfLoops = -1;
        [_backgroundMusicPlayer prepareToPlay];
        [_backgroundMusicPlayer play];
    }
    else {
        
        [_backgroundMusicPlayer stop];
    }
}

@end