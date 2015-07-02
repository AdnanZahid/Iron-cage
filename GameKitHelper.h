//
//  GameKitHelper.h
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "Constants.h"

extern NSString *const PresentAuthenticationViewController;

@interface GameKitHelper : NSObject<GKGameCenterControllerDelegate>

#if TARGET_OS_IPHONE
@property (nonatomic, readonly) UIViewController *authenticationViewController;
#else
@property (nonatomic, readonly) NSViewController *authenticationViewController;
#endif
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedGameKitHelper;

+ (void)reportScore:(NSUInteger)gems;

- (void)authenticateLocalPlayer;

#if TARGET_OS_IPHONE
- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard viewController:(UIViewController *)viewController;
#else
- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard viewController:(NSViewController *)viewController;
#endif

@end