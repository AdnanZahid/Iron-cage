//
//  CloudyText.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/29/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "CloudyText.h"

@implementation CloudyText

int duration = 5;

- (id)initWithStringAndSceneAndGameOver:(NSString *)string scene:(SKScene *)scene gameOver:(BOOL *)gameOver {
    
    if (self = [super init]) {
        
        _text = [[[Text alloc] initWithStringAndXandY:string X:scene.frame.size.width/2 Y:scene.frame.size.height/2] text];
        _text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _text.fontSize = 20;
        _text.fontName = @"Chalkduster";
        
        SKAction *zoomOutAction = [SKAction scaleBy:8 duration:duration * 2];
        SKAction *fadeOutAction = [SKAction fadeOutWithDuration:duration];
        
        *gameOver = !*gameOver;
    
        [_text runAction:zoomOutAction];
        [_text runAction:fadeOutAction completion:^{
                                                    [_text removeFromParent];
                                                    *gameOver = !*gameOver;
        }];
    }
    
    return self;
}

@end