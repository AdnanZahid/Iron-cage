//
//  Background.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : NSObject

@property SKSpriteNode *sprite;

- (id)initWithWidthAndHeight:(CGFloat)width height:(CGFloat)height;

- (id)initWithWidthAndHeightAndImageNamed:(CGFloat)width height:(CGFloat)height imageName:(NSString *)imageName;

@end