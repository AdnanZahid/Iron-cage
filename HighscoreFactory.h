//
//  HighscoreFactory.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighscoreFactory : NSObject

+ (BOOL)orderHighscoresAndReturnIfHighest:(NSUInteger)gems;

@end