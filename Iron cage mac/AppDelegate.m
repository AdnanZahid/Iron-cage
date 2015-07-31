//
//  AppDelegate.m
//  Iron cage Mac
//
//  Created by Adnan Zahid on 6/23/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [_window toggleFullScreen:nil];
    [_window makeKeyWindow];
    
    [SceneFactory sceneFromScratch:[MainMenuScene class] view:_skView];
    
    [iRate sharedInstance].applicationBundleID = @"org.eu5.adnan-zahid.ironcagemac";
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    [iRate sharedInstance].previewMode = NO;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end