//
//  ParticleFactory.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ParticleFactory : NSObject

+ (SKEmitterNode *)particleWithName:(NSString *)name;

+ (SKEmitterNode *)particleWithDuration:(CFTimeInterval)duration target:(SKNode *)target;

@end