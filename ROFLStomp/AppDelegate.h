//
//  AppDelegate.h
//  ROFLStomp
//
//  Created by John King on 11/24/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *playerData;
@property (strong, nonatomic) NSMutableDictionary *levelData;
@property (strong, nonatomic) NSMutableDictionary *enemyData;
@property (strong, nonatomic) NSMutableDictionary *projectileData;
@end
