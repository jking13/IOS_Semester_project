//
//  Enemy.h
//  ROFLStomp
//
//  Created by John King on 12/7/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BasicEntity.h"
@interface Enemy : BasicEntity
@property (strong, nonatomic) NSNumber *moneyValue; //the money gained by killing this enemy
@end
