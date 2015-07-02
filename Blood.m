//
//  Blood.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "Blood.h"

@implementation Blood

- (id)init {
    
    NSString *atlasName = [NSString stringWithFormat:@"blood%d", 1 + arc4random_uniform(4)];
    
    return [self initWithNameAndDuration:atlasName duration:0.5f];
}

- (id)initWithNameAndDuration:(NSString *)atlasName duration:(float)duration {
    
    if (self = [super init]) {
        
        _sprite = [SpriteFactory spriteWithAtlas:atlasName];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC);
        
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [_sprite removeFromParent];
        });
    }
    
    return self;
}

@end