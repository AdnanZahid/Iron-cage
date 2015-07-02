//
//  Platform.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Gear.h"
#import "Drill.h"
#import "Constants.h"
#import "Chain.h"

@interface Platform : SKNode

- (id)initWithLength:(int)length difficulty:(int)difficulty;

@end