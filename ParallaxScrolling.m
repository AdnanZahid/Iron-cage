//
//  ParallaxScrolling.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/12/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "ParallaxScrolling.h"

#define kParallaxBackgroundAntiFlickeringAdjustment 0.05

static inline CGFloat roundFloatToTwoDecimalPlaces(CGFloat num) { return floorf(num * 100 + 0.5) / 100; }

@interface PBParallaxScrolling ()

@property (nonatomic, strong) NSArray * backgrounds;

@property (nonatomic, strong) NSArray * clonedBackgrounds;

@property (nonatomic, strong) NSArray * speeds;

@property (nonatomic) NSUInteger numberOfBackgrounds;

@property (nonatomic) ParallaxType direction;

@property (nonatomic) CGSize size;

@end

@implementation PBParallaxScrolling

- (id) initWithBackgrounds: (NSArray *) backgrounds size: (CGSize) size direction: (ParallaxType) direction fastestSpeed: (CGFloat) speed andSpeedDecrease: (CGFloat) differential {
    self = [super init];
    if (self) {
        
        self.numberOfBackgrounds = 0;
        self.direction = direction;
        self.position = CGPointMake(size.width / 2, size.height / 2);
        self.zPosition = -100;
        
        if (speed < 0) speed = -speed;
        if (differential < 0 || differential > 1) differential = kPBParallaxBackgroundDefaultSpeedDifferential; // sanity check

        CGFloat zPos = 1.0f / backgrounds.count;
        NSUInteger bgNumber = 0;
        NSMutableArray * bgs = [NSMutableArray array];
        NSMutableArray * cBgs = [NSMutableArray array];
        NSMutableArray * spds = [NSMutableArray array];
        CGFloat currentSpeed = roundFloatToTwoDecimalPlaces(speed);
        
        for (id obj in backgrounds) {
            
            SKSpriteNode * node = [[SKSpriteNode alloc] initWithImageNamed:obj];
            
            node.zPosition = self.zPosition - (zPos + (zPos * bgNumber));
            node.position = CGPointMake(0, self.size.height);
            SKSpriteNode * clonedNode = [node copy];
            CGFloat clonedPosX = node.position.x, clonedPosY = node.position.y;
            
            switch (direction) {
                case kParallaxTypeUp:
                    clonedPosY = - node.size.height;
                    break;
                case kParallaxTypeDown:
                    clonedPosY = node.size.height;
                    break;
                case kParallaxTypeRight:
                    clonedPosX = - node.size.width;
                    break;
                case kParallaxTypeLeft:
                    clonedPosX = node.size.width;
                    break;
                default:
                    break;
            }
            clonedNode.position = CGPointMake(clonedPosX, clonedPosY);
            
            [bgs addObject:node];
            [cBgs addObject:clonedNode];
            
            [spds addObject:[NSNumber numberWithFloat:currentSpeed]];
            currentSpeed = roundFloatToTwoDecimalPlaces(currentSpeed / (1 + differential));
            
            [self addChild:node];
            [self addChild:clonedNode];
            
            bgNumber++;
        }
        
        if (bgNumber > 0) {
            self.numberOfBackgrounds = bgNumber;
            self.backgrounds = [bgs copy];
            self.clonedBackgrounds = [cBgs copy];
            self.speeds = [spds copy];
        }
    }
    
    return self;
}

- (void) update:(NSTimeInterval)currentTime {
    for (NSUInteger i = 0; i < self.numberOfBackgrounds; i++) {
        
        CGFloat speed = [[self.speeds objectAtIndex:i] floatValue];
        
        SKSpriteNode * bg = [self.backgrounds objectAtIndex:i];
        SKSpriteNode * cBg = [self.clonedBackgrounds objectAtIndex:i];
        CGFloat newBgX = bg.position.x, newBgY = bg.position.y, newCbgX = cBg.position.x, newCbgY = cBg.position.y;
        
        switch (self.direction) {
            case kParallaxTypeUp:
                newBgY += speed;
                newCbgY += speed;
                if (newBgY >= bg.size.height) newBgY = newCbgY - cBg.size.height + kParallaxBackgroundAntiFlickeringAdjustment;
                if (newCbgY >= cBg.size.height) newCbgY = newBgY - bg.size.height + kParallaxBackgroundAntiFlickeringAdjustment;

                break;
            case kParallaxTypeDown:
                newBgY -= speed;
                newCbgY -= speed;
                if (newBgY <= -bg.size.height) newBgY = newCbgY + cBg.size.height - kParallaxBackgroundAntiFlickeringAdjustment;
                if (newCbgY <= -bg.size.height) newCbgY = newBgY + bg.size.height - kParallaxBackgroundAntiFlickeringAdjustment;

                break;
            case kParallaxTypeRight:
                newBgX += speed;
                newCbgX += speed;
                if (newBgX >= bg.size.width) newBgX = newCbgX - cBg.size.width + kParallaxBackgroundAntiFlickeringAdjustment;
                if (newCbgX >= cBg.size.width) newCbgX =  newBgX - bg.size.width + kParallaxBackgroundAntiFlickeringAdjustment;
                
                break;
            case kParallaxTypeLeft:
                newBgX = newBgX - speed;
                newCbgX = newCbgX - speed;
                if (newBgX <= -bg.size.width) newBgX = newCbgX + cBg.size.width - kParallaxBackgroundAntiFlickeringAdjustment;
                if (newCbgX <= -cBg.size.width) newCbgX = newBgX + bg.size.width - kParallaxBackgroundAntiFlickeringAdjustment;
                break;
            default:
                break;
        }
        
        bg.position = CGPointMake(newBgX, newBgY);
        cBg.position = CGPointMake(newCbgX, newCbgY);
    }
}

- (void) reverseMovementDirection {
    ParallaxType newDirection = self.direction;
    switch (self.direction) {
        case kParallaxTypeDown:
            newDirection = kParallaxTypeUp;
            break;
            
        case kParallaxTypeUp:
            newDirection = kParallaxTypeDown;
            break;
            
        case kParallaxTypeLeft:
            newDirection = kParallaxTypeRight;
            break;
            
        case kParallaxTypeRight:
            newDirection = kParallaxTypeLeft;
            break;
            
        default:
            break;
    }
    self.direction = newDirection;
}

@end