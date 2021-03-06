//
//  AppDelegate.m
//  ROFLStomp
//
//  Created by John King on 11/24/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //load paths
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    //load saved user data
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"PlayerData.plist"];
    
    NSMutableDictionary *pdata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInDocumentsDirectory];
    //if no saved data load default data
    if (!pdata) {
        NSString *plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"PlayerData" ofType:@"plist"];
        
        pdata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    }
    //load the level data
        NSString *plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"LevelData" ofType:@"plist"];
        
        NSMutableDictionary *ldata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    
    //load the enemy data
    plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"EnemyData" ofType:@"plist"];
    
    NSMutableDictionary *edata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    
    //load the projectile data
    plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"ProjectileData" ofType:@"plist"];
    
    NSMutableDictionary *projdata = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    
    //set variables
    self.playerData = pdata;
    self.levelData = ldata;
    self.enemyData = edata;
    self.projectileData = projdata;

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"PlayerData.plist"];
    
    [self.playerData writeToFile:plistFilePathInDocumentsDirectory atomically:YES];
    SKView *view = (SKView *)self.window.rootViewController.view;
    view.paused = YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    SKView *view = (SKView *)self.window.rootViewController.view;
    view.paused = NO;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
