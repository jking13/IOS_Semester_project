//
//  ViewController.m
//  ROFLStomp
//
//  Created by John King on 11/24/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "ViewController.h"
#import "MainMenuScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    CGSize reversed = CGSizeMake(skView.bounds.size.height, skView.bounds.size.width);
    SKScene * scene = [MainMenuScene sceneWithSize:reversed];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
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

@end
