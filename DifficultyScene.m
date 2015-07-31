//
//  DifficultyScene.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/27/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "DifficultyScene.h"

@implementation DifficultyScene {
    
    SKButton *easy;
    SKButton *medium;
    SKButton *hard;
    SKButton *impossible;
}

- (void)didMoveToView:(SKView *)view {
    
    CGFloat width = CGRectGetMaxX(self.frame);
#if TARGET_OS_IPHONE
    CGFloat height = CGRectGetMaxY(self.frame) - kGADAdSizeFullBanner.size.height;
#else
    CGFloat height = CGRectGetMaxY(self.frame);
#endif
    
    easy = [[[Checkbox alloc] initWithName:@"Easy" offset:0 X:width/16 Y:height * 0.65f] checkbox];
    medium = [[[Checkbox alloc] initWithName:@"Medium" offset:0 X:width/16 Y:height * 0.5f] checkbox];
    hard = [[[Checkbox alloc] initWithName:@"Hard" offset:0 X:width/16 Y:height * 0.35f] checkbox];
    impossible = [[[Checkbox alloc] initWithName:@"Impossible" offset:0 X:width/16 Y:height * 0.2f] checkbox];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] == EASY) {
        
        [self setDifficultyEasy];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] == MEDIUM) {
        
        [self setDifficultyMedium];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] == HARD) {
        
        [self setDifficultyHard];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] == IMPOSSIBLE) {
        
        [self setDifficultyImpossible];
    }
    else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] == 0) {
        
        [self setDifficultyMedium];
        
        [[NSUserDefaults standardUserDefaults] setInteger:MEDIUM forKey:@"difficulty"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self addChild:[[[Background alloc] initWithWidthAndHeight:width height:height] sprite]];
    [self addChild:easy];
    [self addChild:medium];
    [self addChild:hard];
    [self addChild:impossible];
    [self addChild:[[[Button alloc] initWithName:@"Back" offset:2 X:width/2 Y:height * 0.2f] button]];
}

- (void)EasyAction {
    
    [self setDifficultyEasy];
    
    [[NSUserDefaults standardUserDefaults] setInteger:EASY forKey:@"difficulty"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AudioFactory soundWithFilename:@"Checkbox" target:self];
}

- (void)MediumAction {
    
    [self setDifficultyMedium];
    
    [[NSUserDefaults standardUserDefaults] setInteger:MEDIUM forKey:@"difficulty"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AudioFactory soundWithFilename:@"Checkbox" target:self];
}

- (void)HardAction {
    
    [self setDifficultyHard];
    
    [[NSUserDefaults standardUserDefaults] setInteger:HARD forKey:@"difficulty"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AudioFactory soundWithFilename:@"Checkbox" target:self];
}

- (void)ImpossibleAction {
    
    [self setDifficultyImpossible];
    
    [[NSUserDefaults standardUserDefaults] setInteger:IMPOSSIBLE forKey:@"difficulty"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AudioFactory soundWithFilename:@"Checkbox" target:self];
}

- (void)BackAction {
    
    [SceneFactory sceneFromScene:[MenuScene class] target:self];
    
    [AudioFactory soundWithFilename:@"Back" target:self];
}

- (void)setDifficultyEasy {
    
    easy.title.text = @"☑ Easy";
    medium.title.text = @"☐ Medium";
    hard.title.text = @"☐ Hard";
    impossible.title.text = @"☐ Impossible";
}

- (void)setDifficultyMedium {
    
    easy.title.text = @"☐ Easy";
    medium.title.text = @"☑ Medium";
    hard.title.text = @"☐ Hard";
    impossible.title.text = @"☐ Impossible";
}

- (void)setDifficultyHard {
    
    easy.title.text = @"☐ Easy";
    medium.title.text = @"☐ Medium";
    hard.title.text = @"☑ Hard";
    impossible.title.text = @"☐ Impossible";
}

- (void)setDifficultyImpossible {
    
    easy.title.text = @"☐ Easy";
    medium.title.text = @"☐ Medium";
    hard.title.text = @"☐ Hard";
    impossible.title.text = @"☑ Impossible";
}

@end