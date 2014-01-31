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
@property (strong, nonatomic) NSNumber *health;//health the entity has
@property (strong, nonatomic) NSNumber *maxHealth;//its maximum health
@property (strong, nonatomic) NSNumber *movementSpeed;//its movement speed
@property (strong, nonatomic) NSNumber *fireRate;//how fast it fires
@property (strong, nonatomic) NSNumber *scaredCount;//used to count the scared movements left to make
@property (strong, nonatomic) NSNumber *fireRange;//how close an elephant has to be to trigger firing
@property NSTimeInterval lastProjectileTimeInterval;//last time a projectile was fired
@property NSTimeInterval lastRegenTimeInterval;//last time health was regened
@property NSTimeInterval lastUpdateTimeInterval;//last time things were updated
@property BOOL shouldFire;//true if it should fire a projectile
@property BOOL shouldRegen;//true if it should regen
@property BOOL hasProjectile;//true if it has the potential to fire a projectile
@property (strong, nonatomic) Projectile *projectile;//a protoype projectile
-(float) getNextAngle;//returns the next angle at which it should move
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast;//updates time dependent data
@end
