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
        
        //spawns the background
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackgroundnotext.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        sn.xScale = size.width/480;
        [self addChild:sn];
        
        //spawns the return to main menu button
        SKSpriteNode *mainMenuButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        mainMenuButton.name = @"mainMenuButton";
        mainMenuButton.size = CGSizeMake(80, 32);
        mainMenuButton.position =CGPointMake(mainMenuButton.size.width/2+10, size.height-mainMenuButton.size.height/2-10);
        mainMenuButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:mainMenuButton];
        SKLabelNode *mainMenuLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [mainMenuButton addChild:mainMenuLabel];
        mainMenuLabel.text = @"Main Menu";
        mainMenuLabel.fontSize = 10;
        mainMenuLabel.position = CGPointMake(mainMenuLabel.position.x, mainMenuLabel.position.y-5);
        
        //level 1 button
        SKSpriteNode *levelOneButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelOneButton.name = @"LevelOneButton";
        levelOneButton.position =CGPointMake(CGRectGetMidX(self.frame)-64, CGRectGetMidY(self.frame)+CGRectGetMidY(self.frame)/2);
        levelOneButton.size = CGSizeMake(80, 32);
        levelOneButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelOneButton];
        SKLabelNode *lvl1Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelOneButton addChild:lvl1Label];
        lvl1Label.text = @"Level 1";
        lvl1Label.fontSize = 10;
        lvl1Label.position = CGPointMake(lvl1Label.position.x, lvl1Label.position.y-5);
        
        //level 2 button
       SKSpriteNode *levelTwoButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelTwoButton.name = @"LevelTwoButton";
        levelTwoButton.position =CGPointMake(CGRectGetMidX(self.frame)+64, CGRectGetMidY(self.frame)+CGRectGetMidY(self.frame)/2);
        levelTwoButton.size = CGSizeMake(80, 32);
        levelTwoButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelTwoButton];
        SKLabelNode *lvl2Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelTwoButton addChild:lvl2Label];
        lvl2Label.text = @"Level 2";
        lvl2Label.fontSize = 10;
        lvl2Label.position = CGPointMake(lvl2Label.position.x, lvl2Label.position.y-5);
        
        //level 3 button
        SKSpriteNode *levelThreeButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelThreeButton.name = @"LevelThreeButton";
        levelThreeButton.position =CGPointMake(CGRectGetMidX(self.frame)-64, CGRectGetMidY(self.frame));
        levelThreeButton.size = CGSizeMake(80, 32);
        levelThreeButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelThreeButton];
        SKLabelNode *lvl3Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelThreeButton addChild:lvl3Label];
        lvl3Label.text = @"Level 3";
        lvl3Label.fontSize = 10;
        lvl3Label.position = CGPointMake(lvl3Label.position.x, lvl3Label.position.y-5);
        
        //level 4 button
        SKSpriteNode *levelFourButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelFourButton.name = @"LevelFourButton";
        levelFourButton.position =CGPointMake(CGRectGetMidX(self.frame)+64, CGRectGetMidY(self.frame));
        levelFourButton.size = CGSizeMake(80, 32);
        levelFourButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelFourButton];
        SKLabelNode *lvl4Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelFourButton addChild:lvl4Label];
        lvl4Label.text = @"Level 4";
        lvl4Label.fontSize = 10;
        lvl4Label.position = CGPointMake(lvl4Label.position.x, lvl4Label.position.y-5);
        
        //level 5 button
        SKSpriteNode *levelFiveButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        levelFiveButton.name = @"LevelFiveButton";
        levelFiveButton.position =CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/2);
        levelFiveButton.size = CGSizeMake(80, 32);
        levelFiveButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:levelFiveButton];
        SKLabelNode *lvl5Label = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [levelFiveButton addChild:lvl5Label];
        lvl5Label.text = @"Level 5";
        lvl5Label.fontSize = 10;
        lvl5Label.position = CGPointMake(lvl5Label.position.x, lvl5Label.position.y-5);
        
       
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        
        //presents the main menu
        if ([node.name isEqualToString:@"mainMenuButton"]) {
            SKView * skView = (SKView *)self.view;
            SKScene * scene = [MainMenuScene sceneWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [skView presentScene:scene];
            return;
        }
        
        //determines which level was selected
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
        else if ([node.name isEqualToString:@"LevelThreeButton"]) {
            level = [level initWithInt:3];
            buttonPressed = true;
        }
        else if ([node.name isEqualToString:@"LevelFourButton"]) {
            level = [level initWithInt:4];
            buttonPressed = true;
        }
        else if ([node.name isEqualToString:@"LevelFiveButton"]) {
            level = [level initWithInt:5];
            buttonPressed = true;
        }
        //if it wasn't a button, continue
        if(!buttonPressed)
            continue;
        
        //presents the selected level
        SKView * skView = (SKView *)self.view;
        LevelScene * scene = [LevelScene alloc];
        scene.currentLevel = level;
        scene = [scene initWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scene];
    }
}

@end
