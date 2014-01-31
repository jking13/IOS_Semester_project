//
//  Mouse.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Mouse : SKSpriteNode
@property (strong, nonatomic) NSMutableArray *scaredElephants; //the list of elephants it has already scared
@property (strong, nonatomic) NSNumber *movementSpeed; //its movement speed
-(void) initialize;
@end
