//
//  Background.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Background.h"

@implementation Background

- (id)initWithWidthAndHeight:(CGFloat)width height:(CGFloat)height {
    
    return [self initWithWidthAndHeightAndImageNamed:width height:height imageName:@"background"];
}

- (id)initWithWidthAndHeightAndImageNamed:(CGFloat)width height:(CGFloat)height imageName:(NSString *)imageName {
    
    if (self = [super init]) {
        
        _sprite= [SKSpriteNode spriteNodeWithImageNamed:imageName];
        
        CGFloat scaleX = width/_sprite.size.width;
        CGFloat scaleY = height/_sprite.size.height;
        
        _sprite.xScale = scaleX;
        _sprite.yScale = scaleY;
        
        _sprite.position = CGPointMake(width/2, height/2);
    }
    
    return self;
}

@end