//
//  SceneFactory.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "SceneFactory.h"

@implementation SceneFactory

+ (void)sceneFromScratch:(Class)scene view:(SKView *)view {
    
    view.ignoresSiblingOrder = YES;
    view.showsFPS = YES;
    
    [view.scene addChild:[[[Background alloc] initWithWidthAndHeightAndImageNamed:view.scene.size.width height:view.scene.size.height imageName:@"prisonDoor"] sprite]];
    
    SKScene *newScene = [scene sceneWithSize:CGSizeMake(1024, 768)];
    SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:2];
    
    [view presentScene:newScene transition:transition];
}

+ (void)sceneFromScene:(Class)scene target:(SKScene *)target {
    
    [target removeAllChildren];
    
    [self sceneFromScratch:scene view:target.view];
}

@end