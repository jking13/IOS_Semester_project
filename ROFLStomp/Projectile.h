//
//  Projectile.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
@interface Projectile : SKSpriteNode
@property (strong, nonatomic) NSNumber *damage; //damage the projectile does
@property (strong, nonatomic) NSNumber *movementSpeed;//the projectiles movement speed
@property (strong, nonatomic) NSString *projectileImageName; //the name of its image file
@property (strong, nonatomic) NSNumber *explosive;//true if it is explosive
@end
