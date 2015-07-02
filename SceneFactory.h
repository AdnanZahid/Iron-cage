//
//  SceneFactory.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"

@interface SceneFactory : NSObject

+ (void)sceneFromScratch:(Class)scene view:(SKView *)view;

+ (void)sceneFromScene:(Class)scene target:(SKScene *)target;

@end