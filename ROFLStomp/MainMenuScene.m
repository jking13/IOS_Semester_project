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
        /* Setup your scene here */
        
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackground.png"];
        
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        
        [self addChild:sn];
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
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        if ([node.name isEqualToString:@"LevelSelectButton"]) {
            SKView * skView = (SKView *)self.view;
            skView.showsFPS = YES;
            skView.showsNodeCount = YES;
            
            // Create and configure the scene.
            SKScene * scene = [LevelSelectScene sceneWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            
            // Present the scene.
            [skView presentScene:scene];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
