//
//  Mouse.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Mouse : SKSpriteNode
@property (strong, nonatomic) NSMutableArray *scaredElephants;
@property (strong, nonatomic) NSNumber *movementSpeed;
-(void) initialize;
@end
