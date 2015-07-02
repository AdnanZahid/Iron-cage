//
//  Checkbox.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKButton.h"

@interface Checkbox : NSObject

@property SKButton *checkbox;

- (id)initWithName:(NSString *)buttonName offset:(int)offset X:(CGFloat)X Y:(CGFloat)Y;

@end