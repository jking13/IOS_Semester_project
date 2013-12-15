//
//  Elephant.m
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "Elephant.h"

@implementation Elephant
-(void) initializeData: (NSNumber*) health : (NSNumber*) movementSpeed
{
    [super initializeData:health :movementSpeed];
    self.attacking = false;
    self.scaredCount = [NSNumber numberWithInt:0];
}
@end
