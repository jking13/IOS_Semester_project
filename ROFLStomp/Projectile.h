//
//  Projectile.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
@interface Projectile : SKSpriteNode
@property (strong, nonatomic) NSNumber *damage;
@property (strong, nonatomic) NSNumber *movementSpeed;
@property (strong, nonatomic) NSString *projectileImageName;
-(void) initializeData: (NSNumber*) damage : (NSNumber*) movementSpeed;
@end
