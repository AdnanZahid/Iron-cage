//
//  AudioFactory.h
//  Iron cage
//
//  Created by Adnan Zahid on 7/1/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

@interface AudioFactory : NSObject

+ (void)musicWithFilename:(NSString *)filename;

+ (AVAudioPlayer *)sharedInstance;

+ (void)soundWithFilename:(NSString *)filename target:(SKNode *)target;

@end