//
//  Text.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Text : NSObject

@property SKLabelNode *text;

- (id)initWithStringAndXandY:(NSString *)string X:(CGFloat)X Y:(CGFloat)Y;

@end