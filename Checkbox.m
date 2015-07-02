//
//  Checkbox.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Checkbox.h"

@implementation Checkbox

- (id)initWithName:(NSString *)buttonName offset:(int)offset X:(CGFloat)X Y:(CGFloat)Y {
    
    if (self = [super init]) {
        
        _checkbox = [[SKButton alloc] initWithImageNamedNormal:@"checkbox" selected:@"transparent"];
        
        _checkbox.position = CGPointMake(offset * _checkbox.size.width/2 + X, Y + _checkbox.size.height/2);
        _checkbox.title.text = buttonName;
        _checkbox.title.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _checkbox.title.fontSize = 50;
        
        
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", buttonName, @"Action"]);
        
        [_checkbox setTouchUpInsideTarget:self action:selector];
    }
    
    return self;
}

@end