//
//  LevelScene.h
//  ROFLStomp
//
//  Created by John King on 12/3/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Elephant.h"
#import "Enemy.h"
#import "Mouse.h"
#import "Projectile.h"
#import "AppDelegate.h"
#import "BasicEntity.h"
#import "LevelSelectScene.h"
@interface LevelScene : SKScene

@property (strong, nonatomic) NSNumber *currentLevel;
@property (strong, nonatomic) NSMutableDictionary *playerData;
@property (strong, nonatomic) NSMutableDictionary *levelData;
@property (strong, nonatomic) NSDictionary *currentLevelData;
@property (strong, nonatomic) NSMutableDictionary *enemyData;
@property (strong, nonatomic) NSMutableDictionary *projectileData;
@end
