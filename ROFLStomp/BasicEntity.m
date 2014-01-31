//
//  BasicEntity.m
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "BasicEntity.h"

@implementation BasicEntity

//updates time dependent data
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastProjectileTimeInterval += timeSinceLast;
    self.lastRegenTimeInterval += timeSinceLast;
    if (self.lastProjectileTimeInterval > 1.0/[self.fireRate floatValue]) {
        self.lastProjectileTimeInterval = 0.0;
        self.shouldFire = true;
    }
    if(self.lastRegenTimeInterval > 1.0)
    {
        self.lastRegenTimeInterval = 0.0;
        self.health = [NSNumber numberWithInt:[self.health intValue]+5];
        if ([self.health intValue]>[self.maxHealth intValue]) {
            self.health = [NSNumber numberWithInt:[self.maxHealth intValue]];
        }
    }
}
//returns the next angle at which it should move, is semi-random movement
-(float) getNextAngle
{
    if([self.scaredCount intValue]>0)
    {
        return self.zRotation;
    }
    int rand = arc4random()%10;
    //same angle
    if(rand<3)
    {
        return self.zRotation;
    }
    //within 90 degrees of current angle
    else
    {
        int sign = 1;
        if(arc4random()%2)
        {
            sign = -1;
        }
        
        float offset = (arc4random()%100)/100.0f;
        offset = offset * sign * M_PI/4;
        return offset+self.zRotation;
    }

}
@end
