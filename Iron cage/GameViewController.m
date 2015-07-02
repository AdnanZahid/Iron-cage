//
//  GameViewController.m
//  Iron cage
//
//  Created by Adnan Zahid on 6/12/15.
//  Copyright (c) 2015 Adnan Zahid. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
    
    bannerView.adUnitID = @"ca-app-pub-7152525679107278/9891392742";
    bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [bannerView loadRequest:request];
    
    SKView *skView = (SKView *)self.view;
    
    bannerView.rootViewController = self;
    [skView addSubview:bannerView];
    
    [SceneFactory sceneFromScratch:[MainMenuScene class] view:skView];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end