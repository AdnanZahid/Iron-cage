//
//  Text.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Text.h"

@implementation Text

- (id)initWithStringAndXandY:(NSString *)string X:(CGFloat)X Y:(CGFloat)Y {
    
    if (self = [super init]) {
        
        _text = [SKLabelNode labelNodeWithText:string];
        _text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _text.position = CGPointMake(X, Y);
        
        _text.fontName = @"AcademyEngravedLetPlain";
        _text.fontSize = 55;
        _text.color = [SKColor whiteColor];
        
        _text.zPosition = 19;
    }
    
    return self;
}

@end