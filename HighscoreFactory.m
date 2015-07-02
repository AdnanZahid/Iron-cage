//
//  HighscoreFactory.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "HighscoreFactory.h"

@implementation HighscoreFactory

+ (BOOL)orderHighscoresAndReturnIfHighest:(NSUInteger)gems {
    
    NSMutableArray *highscoreArray = [NSMutableArray array];

    for (int i = 0; i < 5; i++) {

        NSString *scoreOrder = [NSString stringWithFormat:@"highscore%d",i];
        NSUInteger score = [[NSUserDefaults standardUserDefaults] integerForKey:scoreOrder];

        [highscoreArray addObject:[NSNumber numberWithUnsignedInteger:score]];
    }
    
    [highscoreArray addObject:[NSNumber numberWithUnsignedInteger:gems]];
    
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:highscoreArray];
    NSMutableArray *highscoreArrayWithoutDuplicates = [[orderedSet array] mutableCopy];
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [highscoreArrayWithoutDuplicates sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    NSUInteger highestScore = [[highscoreArrayWithoutDuplicates objectAtIndex:0]unsignedIntegerValue];
    
    for (int i = 0; i < 5; i++) {
        
        [highscoreArrayWithoutDuplicates addObject:[NSNumber numberWithInteger:0]];
    }
    
    for (int i = 0; i < 5; i++) {
        
        NSString *scoreOrder = [NSString stringWithFormat:@"highscore%d",i];
        NSUInteger score = [[highscoreArrayWithoutDuplicates objectAtIndex:i]unsignedIntegerValue];
        
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey: scoreOrder];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (gems >= highestScore) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

@end