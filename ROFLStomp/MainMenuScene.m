//
//  MyScene.m
//  ROFLStomp
//
//  Created by John King on 11/24/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        //spawns the background
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackground.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        sn.xScale = size.width/480;
        [self addChild:sn];
        
        //spawns the level selection menu button
        SKSpriteNode *levelSelectButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelSelectButton.name = @"LevelSelectButton";
        levelSelectButton.position =CGPointMake(CGRectGetMidX(self.frame)-64, CGRectGetMidY(self.frame));
        levelSelectButton.size = CGSizeMake(80, 32);
        levelSelectButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelSelectButton];
        SKLabelNode *selectLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelSelectButton addChild:selectLabel];
        selectLabel.text = @"Select Level";
        selectLabel.fontSize = 10;
        selectLabel.position = CGPointMake(selectLabel.position.x, selectLabel.position.y-5);
        
        //spawns the upgrade selection menu button
        SKSpriteNode *upgradeButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        upgradeButton.name = @"UpgradeButton";
        upgradeButton.position =CGPointMake(CGRectGetMidX(self.frame)+64, CGRectGetMidY(self.frame));
        upgradeButton.size = CGSizeMake(80, 32);
        upgradeButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:upgradeButton];
        SKLabelNode *upgradeLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [upgradeButton addChild:upgradeLabel];
        upgradeLabel.text = @"Upgrades";
        upgradeLabel.fontSize = 10;
        upgradeLabel.position = CGPointMake(upgradeLabel.position.x, upgradeLabel.position.y-5);
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        //presents the level selection scene
        if ([node.name isEqualToString:@"LevelSelectButton"]) {
            SKView * skView = (SKView *)self.view;
            SKScene * scene = [LevelSelectScene sceneWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [skView presentScene:scene];
        }
        
        //presents the upgrade selection scene
        if ([node.name isEqualToString:@"UpgradeButton"]) {
            SKView * skView = (SKView *)self.view;
            SKScene * scene = [UpgradesScene sceneWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [skView presentScene:scene];
        }
    }
}

@end
