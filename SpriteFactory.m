//
//  SpriteFactory.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/24/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "SpriteFactory.h"

@implementation SpriteFactory

+ (SKSpriteNode *)spriteWithAtlas:(NSString *)atlasName {
    
    NSMutableArray *frames = [NSMutableArray array];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName];
    
    for (int i=1; i <= atlas.textureNames.count; i++) {
        NSString *textureName = [NSString stringWithFormat:@"image%d", i];
        SKTexture *temp = [atlas textureNamed:textureName];
        [frames addObject:temp];
    }
    SKTexture *texture = frames[0];
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
    
    [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:frames
                                                                      timePerFrame:0.1f
                                                                            resize:YES
                                                                           restore:YES]]];
    
    return sprite;
}

@end