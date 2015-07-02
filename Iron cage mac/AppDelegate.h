//
//  AppDelegate.h
//  Iron cage Mac
//

//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import "SceneFactory.h"
#import "MainMenuScene.h"
#import "iRate.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;

@end