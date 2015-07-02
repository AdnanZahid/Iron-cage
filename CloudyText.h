//
//  CloudyText.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/29/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Text.h"

@interface CloudyText : NSObject

@property SKLabelNode *text;

- (id)initWithStringAndSceneAndGameOver:(NSString *)string scene:(SKScene *)scene gameOver:(BOOL *)gameOver;

@end