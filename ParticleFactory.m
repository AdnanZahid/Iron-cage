//
//  ParticleFactory.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "ParticleFactory.h"

@implementation ParticleFactory

+ (SKEmitterNode *)particleWithName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"sks"];
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return emitter;
}

+ (SKEmitterNode *)particleWithDuration:(CFTimeInterval)duration target:(SKNode *)target {
    
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"]];
    
    emitter.targetNode = target;
    emitter.numParticlesToEmit = duration * emitter.particleBirthRate;
    CFTimeInterval totalTime = duration + emitter.particleLifetime+emitter.particleLifetimeRange/2;
    [emitter runAction:[SKAction sequence:@[[SKAction waitForDuration:totalTime],
                                            [SKAction removeFromParent]]]];
    return emitter;
}

@end