//
//  LevelSelectScene.m
//  ROFLStomp
//
//  Created by John King on 12/3/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "LevelSelectScene.h"

@implementation LevelSelectScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackgroundnotext.png"];
        
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        
        [self addChild:sn];
        SKSpriteNode *levelOneButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelOneButton.name = @"LevelOneButton";
        levelOneButton.position =CGPointMake(CGRectGetMidX(self.frame)-64, CGRectGetMidY(self.frame));
        levelOneButton.size = CGSizeMake(80, 32);
        levelOneButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelOneButton];
        SKLabelNode *lvl1Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelOneButton addChild:lvl1Label];
        lvl1Label.text = @"Level 1";
        lvl1Label.fontSize = 10;
        lvl1Label.position = CGPointMake(lvl1Label.position.x, lvl1Label.position.y-5);
        
       
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        if ([node.name isEqualToString:@"LevelOneButton"]) {
            SKView * skView = (SKView *)self.view;
            skView.showsFPS = YES;
            skView.showsNodeCount = YES;
            
            // Create and configure the scene.
            NSNumber *level = [NSNumber alloc];
            level = [level initWithInt:1];
            LevelScene * scene = [LevelScene alloc];
            scene.currentLevel = level;
            //[scene.userData setObject:level forKey:@"current level"];
            scene = [scene initWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            // Present the scene.
            [skView presentScene:scene];
        }
    }
}

@end
