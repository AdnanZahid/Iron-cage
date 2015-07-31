//
//  GameKitHelper.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/28/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "GameKitHelper.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";
NSString *const LocalPlayerIsAuthenticated = @"local_player_authenticated";

@implementation GameKitHelper {
    BOOL _enableGameCenter;
    BOOL _matchStarted;
}

+ (instancetype)sharedGameKitHelper {
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

+ (void)reportScore:(NSUInteger)gems {
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:LEADERBOARDIDENTIFIER];
    score.value = gems;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {}];
}

- (void)authenticateLocalPlayer {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    if (localPlayer.isAuthenticated) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];
        return;
    }
    
#if TARGET_OS_IPHONE
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
#else
    localPlayer.authenticateHandler = ^(NSViewController *viewController, NSError *error) {
#endif
        
        if(viewController != nil) {
            
            [self setAuthenticationViewController:viewController];
        } else if([GKLocalPlayer localPlayer].isAuthenticated) {
            
            _enableGameCenter = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];
        } else {
            
            _enableGameCenter = NO;
        }
    };
}
    
#if TARGET_OS_IPHONE
    - (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard viewController:(UIViewController *)viewController {
        
        GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
        
        gcViewController.gameCenterDelegate = self;
        
        if (shouldShowLeaderboard) {
            gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
            
            gcViewController.leaderboardIdentifier = LEADERBOARDIDENTIFIER;
        }
        else{
            gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
        }
        [viewController presentViewController:gcViewController animated:YES completion:nil];
    }
    
    -(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
        
        [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
    }
#else
    - (void)showLeaderboard:(NSWindow *)window {
        
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
        
        if (gameCenterController != nil) {
            gameCenterController.gameCenterDelegate = self;
            gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
            gameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
            gameCenterController.leaderboardCategory = LEADERBOARDIDENTIFIER;
            GKDialogController *sdc = [GKDialogController sharedDialogController];
            sdc.parentWindow = window;
            [sdc presentViewController: gameCenterController];
        }
    }
    
    - (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
        
        GKDialogController *sdc = [GKDialogController sharedDialogController];
        [sdc dismiss: self];
    }
#endif
    
#if TARGET_OS_IPHONE
    - (void)setAuthenticationViewController:(UIViewController *)authenticationViewController {
#else
    - (void)setAuthenticationViewController:(NSViewController *)authenticationViewController {
#endif
    
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
    
}

@end