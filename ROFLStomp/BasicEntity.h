//
//  BasicEntity.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Projectile.h"
@interface BasicEntity : SKSpriteNode
@property (strong, nonatomic) NSNumber *health;
@property (strong, nonatomic) NSNumber *maxHealth;
@property (strong, nonatomic) NSNumber *movementSpeed;
@property (strong, nonatomic) NSNumber *fireRate;
@property (strong, nonatomic) NSNumber *scaredCount;
@property (strong, nonatomic) NSNumber *fireRange;
@property NSTimeInterval lastProjectileTimeInterval;
@property NSTimeInterval lastUpdateTimeInterval;
@property BOOL shouldFire;
@property BOOL hasProjectile;
@property (strong, nonatomic) Projectile *projectile;
-(float) getNextAngle;
-(void) initializeData: (NSNumber*) health : (NSNumber*) movementSpeed;
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast;
@end
