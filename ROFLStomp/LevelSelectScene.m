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
        
        
       SKSpriteNode *levelTwoButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelTwoButton.name = @"LevelTwoButton";
        levelTwoButton.position =CGPointMake(CGRectGetMidX(self.frame)+64, CGRectGetMidY(self.frame));
        levelTwoButton.size = CGSizeMake(80, 32);
        levelTwoButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelTwoButton];
        SKLabelNode *lvl2Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelTwoButton addChild:lvl2Label];
        lvl2Label.text = @"Level 2";
        lvl2Label.fontSize = 10;
        lvl2Label.position = CGPointMake(lvl2Label.position.x, lvl2Label.position.y-5);
        
       
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        NSNumber *level = [NSNumber alloc];
        BOOL buttonPressed = false;
        if ([node.name isEqualToString:@"LevelOneButton"]) {
            level = [level initWithInt:1];
            buttonPressed = true;
        }
        else if ([node.name isEqualToString:@"LevelTwoButton"]) {
            level = [level initWithInt:2];
            buttonPressed = true;
        }
        if(!buttonPressed)
            continue;
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        LevelScene * scene = [LevelScene alloc];
        scene.currentLevel = level;
        //[scene.userData setObject:level forKey:@"current level"];
        scene = [scene initWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        // Present the scene.
        [skView presentScene:scene];
    }
}

@end
