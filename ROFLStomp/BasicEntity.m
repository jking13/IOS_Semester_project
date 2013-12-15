//
//  BasicEntity.m
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "BasicEntity.h"

@implementation BasicEntity

-(void) initializeData: (NSNumber*) health : (NSNumber*) movementSpeed
{
    self.movementSpeed = movementSpeed;
    self.health = health;
    self.scaredCount = [NSNumber numberWithInt:0];
}
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastProjectileTimeInterval += timeSinceLast;
    if (self.lastProjectileTimeInterval > 1.0/[self.fireRate floatValue]) {
        self.lastProjectileTimeInterval = 0.0;
        self.shouldFire = true;
    }
}
-(float) getNextAngle
{
    if([self.scaredCount intValue]>0)
    {
        return self.zRotation;
    }
    int rand = arc4random()%10;
    if(rand<3)
    {
        return self.zRotation;
    }
    //if(rand <7)
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
   /* if (rand<9) {
        int sign = 1;
        if(arc4random()%2)
        {
            sign = -1;
        }
        
        float offset = (arc4random()%100)/100.0f;
        offset = offset * sign * M_PI/4;
        offset = offset + M_PI/4 * sign;
        return offset+self.zRotation;
    }
    else
    {
        int sign = 1;
        if(arc4random()%2)
        {
            sign = -1;
        }
        
        float offset = (arc4random()%100)/100.0f;
        offset = offset * sign * M_PI/2;
        offset = offset + M_PI/2 * sign;
        return offset+self.zRotation;
    }*/
}
@end
