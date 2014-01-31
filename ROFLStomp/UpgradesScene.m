//
//  UpgradesScene.m
//  ROFLStomp
//
//  Created by John King on 12/3/13.
//  Copyright (c) 2013 John King. All rights reserved.
//

#import "UpgradesScene.h"
@interface UpgradesScene ()
@property (strong, nonatomic) SKLabelNode *doubleHealthButtonLabel;
@property (strong, nonatomic) SKLabelNode *armorButtonLabel;
@property (strong, nonatomic) SKLabelNode *scaryButtonLabel;
@property (strong, nonatomic) SKLabelNode *regenButtonLabel;
@property (strong, nonatomic) SKLabelNode *totalMoneyLabel;
@end

@implementation UpgradesScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //bring in data
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.playerData = appDelegate.playerData;
        
        //make the background
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainbackgroundnotext.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        sn.xScale = size.width/480;
        [self addChild:sn];
        
        //display the amount of money the player has
        SKLabelNode *moneyLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        moneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
        moneyLabel.position =CGPointMake(self.frame.size.width-moneyLabel.frame.size.width-10, moneyLabel.frame.size.height/2+10);
        moneyLabel.fontSize = 16;
        moneyLabel.fontColor = [UIColor yellowColor];
        [self addChild:moneyLabel];
        self.totalMoneyLabel = moneyLabel;
        
        //made specifically to make grading and testing easier, not for actual game
        SKSpriteNode *developerButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        developerButton.name = @"developerButton";
        developerButton.size = CGSizeMake(120, 32);
        developerButton.position =CGPointMake(developerButton.size.width/2+10, developerButton.size.height/2+10);
        developerButton.centerRect = CGRectMake(36.0/120.0,5.0/32.0,4.0/120.0,22.0/32.0);
        [self addChild:developerButton];
        SKLabelNode *developerLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [developerButton addChild:developerLabel];
        developerLabel.text = @"Grader only: add money to test";
        developerLabel.fontSize = 8;
        developerLabel.position = CGPointMake(developerLabel.position.x, developerLabel.position.y-5);
        
        //main menu button
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
        
        //double health button
        NSMutableArray *doubleHealthData = [self.playerData objectForKey:@"Double Health"];
        NSNumber *cost = [doubleHealthData objectAtIndex:0];
        NSNumber *unlocked = [doubleHealthData objectAtIndex:1];
        NSNumber *equipped = [doubleHealthData objectAtIndex:2];
        SKSpriteNode *doubleHealthButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        doubleHealthButton.name = @"doubleHealthButton";
        doubleHealthButton.position =CGPointMake(CGRectGetMidX(self.frame)-80, CGRectGetMidY(self.frame)/2+CGRectGetMidY(self.frame));
        doubleHealthButton.size = CGSizeMake(80, 32);
        doubleHealthButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:doubleHealthButton];
        SKLabelNode *doubleHealthLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [doubleHealthButton addChild:doubleHealthLabel];
        if([unlocked boolValue])
        {
            if([equipped boolValue])
                doubleHealthLabel.text = @"Unequip";
            else
                doubleHealthLabel.text = @"Equip";
        }
        else
            doubleHealthLabel.text = [NSString stringWithFormat:@"Cost: %d",[cost intValue]];
        doubleHealthLabel.fontSize = 10;
        doubleHealthLabel.position = CGPointMake(doubleHealthLabel.position.x, doubleHealthLabel.position.y-5);
        self.doubleHealthButtonLabel = doubleHealthLabel;
        
        SKLabelNode *doubleHealthDescription = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:doubleHealthDescription];
        doubleHealthDescription.position = CGPointMake(doubleHealthButton.position.x, doubleHealthButton.position.y+25);
        doubleHealthDescription.fontSize = 8;
        doubleHealthDescription.text = [doubleHealthData objectAtIndex:4];
        
        SKLabelNode *doubleHealthTitle = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:doubleHealthTitle];
        doubleHealthTitle.position = CGPointMake(doubleHealthDescription.position.x, doubleHealthDescription.position.y+10);
        doubleHealthTitle.fontSize = 8;
        doubleHealthTitle.text = [doubleHealthData objectAtIndex:3];
        
        //armor button
        NSMutableArray *armorData = [self.playerData objectForKey:@"Armor"];
        cost = [armorData objectAtIndex:0];
        unlocked = [armorData objectAtIndex:1];
        equipped = [armorData objectAtIndex:2];
        SKSpriteNode *armorButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        armorButton.name = @"armorButton";
        armorButton.position =CGPointMake(CGRectGetMidX(self.frame)+80, CGRectGetMidY(self.frame)/2+CGRectGetMidY(self.frame));
        armorButton.size = CGSizeMake(80, 32);
        armorButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:armorButton];
        SKLabelNode *armorLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [armorButton addChild:armorLabel];
        if([unlocked boolValue])
        {
            if([equipped boolValue])
                armorLabel.text = @"Unequip";
            else
                armorLabel.text = @"Equip";
        }
        else
            armorLabel.text = [NSString stringWithFormat:@"Cost: %d",[cost intValue]];
        armorLabel.fontSize = 10;
        armorLabel.position = CGPointMake(armorLabel.position.x, armorLabel.position.y-5);
        self.armorButtonLabel = armorLabel;
        
        SKLabelNode *armorDescription = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:armorDescription];
        armorDescription.position = CGPointMake(armorButton.position.x, armorButton.position.y+25);
        armorDescription.fontSize = 8;
        armorDescription.text = [armorData objectAtIndex:4];
        
        SKLabelNode *armorTitle = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:armorTitle];
        armorTitle.position = CGPointMake(armorDescription.position.x, armorDescription.position.y+10);
        armorTitle.fontSize = 8;
        armorTitle.text = [armorData objectAtIndex:3];
        
        //scary button
        NSMutableArray *scaryData = [self.playerData objectForKey:@"Scary Mice"];
        cost = [scaryData objectAtIndex:0];
        unlocked = [scaryData objectAtIndex:1];
        equipped = [scaryData objectAtIndex:2];
        SKSpriteNode *scaryButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        scaryButton.name = @"scaryButton";
        scaryButton.position =CGPointMake(CGRectGetMidX(self.frame)+80, CGRectGetMidY(self.frame));
        scaryButton.size = CGSizeMake(80, 32);
        scaryButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:scaryButton];
        SKLabelNode *scaryLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [scaryButton addChild:scaryLabel];
        if([unlocked boolValue])
        {
            if([equipped boolValue])
                scaryLabel.text = @"Unequip";
            else
                scaryLabel.text = @"Equip";
        }
        else
            scaryLabel.text = [NSString stringWithFormat:@"Cost: %d",[cost intValue]];
        scaryLabel.fontSize = 10;
        scaryLabel.position = CGPointMake(scaryLabel.position.x, scaryLabel.position.y-5);
        self.scaryButtonLabel = scaryLabel;
        
        SKLabelNode *scaryDescription = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:scaryDescription];
        scaryDescription.position = CGPointMake(scaryButton.position.x, scaryButton.position.y+25);
        scaryDescription.fontSize = 8;
        scaryDescription.text = [scaryData objectAtIndex:4];
        
        SKLabelNode *scaryTitle = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:scaryTitle];
        scaryTitle.position = CGPointMake(scaryDescription.position.x, scaryDescription.position.y+10);
        scaryTitle.fontSize = 8;
        scaryTitle.text = [scaryData objectAtIndex:3];
        
        //Regen Button
        NSMutableArray *regenData = [self.playerData objectForKey:@"Regen"];
        cost = [regenData objectAtIndex:0];
        unlocked = [regenData objectAtIndex:1];
        equipped = [regenData objectAtIndex:2];
        SKSpriteNode *regenButton =[SKSpriteNode spriteNodeWithImageNamed:@"buttonscale.png"];
        regenButton.name = @"regenButton";
        regenButton.position =CGPointMake(CGRectGetMidX(self.frame)-80, CGRectGetMidY(self.frame));
        regenButton.size = CGSizeMake(80, 32);
        regenButton.centerRect = CGRectMake(36.0/80.0,5.0/32.0,4.0/80.0,22.0/32.0);
        [self addChild:regenButton];
        SKLabelNode *regenLabel = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [regenButton addChild:regenLabel];
        if([unlocked boolValue])
        {
            if([equipped boolValue])
                regenLabel.text = @"Unequip";
            else
                regenLabel.text = @"Equip";
        }
        else
            regenLabel.text = [NSString stringWithFormat:@"Cost: %d",[cost intValue]];
        regenLabel.fontSize = 10;
        regenLabel.position = CGPointMake(regenLabel.position.x, regenLabel.position.y-5);
        self.regenButtonLabel = regenLabel;
        
        SKLabelNode *regenDescription = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:regenDescription];
        regenDescription.position = CGPointMake(regenButton.position.x, regenButton.position.y+25);
        regenDescription.fontSize = 8;
        regenDescription.text = [regenData objectAtIndex:4];
        
        SKLabelNode *regenTitle = [SKLabelNode labelNodeWithFontNamed:@"Times"];
        [self addChild:regenTitle];
        regenTitle.position = CGPointMake(regenDescription.position.x, regenDescription.position.y+10);
        regenTitle.fontSize = 8;
        regenTitle.text = [regenData objectAtIndex:3];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    for (SKNode *node in nodes) {
        NSNumber *money = [self.playerData objectForKey:@"Money"];
        //present the main menu
        if ([node.name isEqualToString:@"mainMenuButton"]) {
            SKView * skView = (SKView *)self.view;
            SKScene * scene = [MainMenuScene sceneWithSize:skView.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [skView presentScene:scene];
            return;
        }
        //give money for testing
        if ([node.name isEqualToString:@"developerButton"]) {
            [self.playerData setObject:[NSNumber numberWithInt:100000] forKey:@"Money"];
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
            return;
        }
        //turn on the upgrades
        if ([node.name isEqualToString:@"doubleHealthButton"]) {
            NSMutableArray *doubleHealthData = [self.playerData objectForKey:@"Double Health"];
            NSNumber *cost = [doubleHealthData objectAtIndex:0];
            NSNumber *unlocked = [doubleHealthData objectAtIndex:1];
            NSNumber *equipped = [doubleHealthData objectAtIndex:2];
            if([unlocked boolValue])
            {
                if([equipped boolValue])
                    self.doubleHealthButtonLabel.text = @"Equip";
                else
                    self.doubleHealthButtonLabel.text = @"Unequip";
                equipped = [NSNumber numberWithBool:![equipped boolValue]];
                [doubleHealthData replaceObjectAtIndex:2 withObject:equipped];
            }
            else
            {
                if([cost intValue]<=[money intValue])
                {
                    NSNumber *newMoney = [NSNumber numberWithInt:[money intValue]-[cost intValue]];
                    unlocked = [NSNumber numberWithBool:true];
                    equipped = [NSNumber numberWithBool:true];
                    [doubleHealthData replaceObjectAtIndex:1 withObject:unlocked];
                    [doubleHealthData replaceObjectAtIndex:2 withObject:equipped];
                    self.doubleHealthButtonLabel.text = @"Unequip";
                    [self.playerData setObject:newMoney forKey:@"Money"];
                    self.totalMoneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
                }
            }
        }
        
        if ([node.name isEqualToString:@"armorButton"]) {
            NSMutableArray *armorData = [self.playerData objectForKey:@"Armor"];
            NSNumber *cost = [armorData objectAtIndex:0];
            NSNumber *unlocked = [armorData objectAtIndex:1];
            NSNumber *equipped = [armorData objectAtIndex:2];
            if([unlocked boolValue])
            {
                if([equipped boolValue])
                    self.armorButtonLabel.text = @"Equip";
                else
                    self.armorButtonLabel.text = @"Unequip";
                equipped = [NSNumber numberWithBool:![equipped boolValue]];
                [armorData replaceObjectAtIndex:2 withObject:equipped];
            }
            else
            {
                if([cost intValue]<=[money intValue])
                {
                    NSNumber *newMoney = [NSNumber numberWithInt:[money intValue]-[cost intValue]];
                    unlocked = [NSNumber numberWithBool:true];
                    equipped = [NSNumber numberWithBool:true];
                    [armorData replaceObjectAtIndex:1 withObject:unlocked];
                    [armorData replaceObjectAtIndex:2 withObject:equipped];
                    self.armorButtonLabel.text = @"Unequip";
                    [self.playerData setObject:newMoney forKey:@"Money"];
                    self.totalMoneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
                }
            }
        }
        
        
        if ([node.name isEqualToString:@"scaryButton"]) {
            NSMutableArray *scaryData = [self.playerData objectForKey:@"Scary Mice"];
            NSNumber *cost = [scaryData objectAtIndex:0];
            NSNumber *unlocked = [scaryData objectAtIndex:1];
            NSNumber *equipped = [scaryData objectAtIndex:2];
            if([unlocked boolValue])
            {
                if([equipped boolValue])
                    self.scaryButtonLabel.text = @"Equip";
                else
                    self.scaryButtonLabel.text = @"Unequip";
                equipped = [NSNumber numberWithBool:![equipped boolValue]];
                [scaryData replaceObjectAtIndex:2 withObject:equipped];
            }
            else
            {
                if([cost intValue]<=[money intValue])
                {
                    NSNumber *newMoney = [NSNumber numberWithInt:[money intValue]-[cost intValue]];
                    unlocked = [NSNumber numberWithBool:true];
                    equipped = [NSNumber numberWithBool:true];
                    [scaryData replaceObjectAtIndex:1 withObject:unlocked];
                    [scaryData replaceObjectAtIndex:2 withObject:equipped];
                    self.scaryButtonLabel.text = @"Unequip";
                    [self.playerData setObject:newMoney forKey:@"Money"];
                    self.totalMoneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
                }
            }
        }
        
        if ([node.name isEqualToString:@"regenButton"]) {
            NSMutableArray *regenData = [self.playerData objectForKey:@"Regen"];
            NSNumber *cost = [regenData objectAtIndex:0];
            NSNumber *unlocked = [regenData objectAtIndex:1];
            NSNumber *equipped = [regenData objectAtIndex:2];
            if([unlocked boolValue])
            {
                if([equipped boolValue])
                    self.regenButtonLabel.text = @"Equip";
                else
                    self.regenButtonLabel.text = @"Unequip";
                equipped = [NSNumber numberWithBool:![equipped boolValue]];
                [regenData replaceObjectAtIndex:2 withObject:equipped];
            }
            else
            {
                if([cost intValue]<=[money intValue])
                {
                    NSNumber *newMoney = [NSNumber numberWithInt:[money intValue]-[cost intValue]];
                    unlocked = [NSNumber numberWithBool:true];
                    equipped = [NSNumber numberWithBool:true];
                    [regenData replaceObjectAtIndex:1 withObject:unlocked];
                    [regenData replaceObjectAtIndex:2 withObject:equipped];
                    self.regenButtonLabel.text = @"Unequip";
                    [self.playerData setObject:newMoney forKey:@"Money"];
                    self.totalMoneyLabel.text = [NSString stringWithFormat:@"Money: %d",[[self.playerData objectForKey:@"Money"] intValue]];
                }
            }
        }


    }
}

@end

