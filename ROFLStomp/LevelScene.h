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

@property (strong, nonatomic) NSNumber *currentLevel; //current level number
@property (strong, nonatomic) NSMutableDictionary *playerData;//saved player info
@property (strong, nonatomic) NSMutableDictionary *levelData;//all the level info
@property (strong, nonatomic) NSDictionary *currentLevelData;////current level info
@property (strong, nonatomic) NSMutableDictionary *enemyData;//all enemy info
@property (strong, nonatomic) NSMutableDictionary *projectileData;//all projectile info
@end
