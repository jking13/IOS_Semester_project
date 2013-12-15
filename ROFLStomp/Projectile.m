//
//  Projectile.m
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile
-(void) initializeData: (NSNumber*) damage : (NSNumber*) movementSpeed
{
    self.movementSpeed = movementSpeed;
    self.damage = damage;
}
@end
