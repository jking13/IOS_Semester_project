//
//  Mouse.m
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "Mouse.h"

@implementation Mouse
-(void) initialize
{
    self.scaredElephants = [[NSMutableArray alloc]init];
    self.movementSpeed = [NSNumber numberWithInt:150];
}
@end
